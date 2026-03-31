//
//  CustomAsyncImage.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CustomAsyncImage: View {
    private let imageUrl: String
    private let aspectRatio: CGFloat?
    private let contentMode: ContentMode

    @State private var uiImage: UIImage?
    @State private var isLoading = false

    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        return URLSession(configuration: config)
    }()

    init(imageUrl: String, _ aspectRatio: CGFloat? = nil, _ contentMode: ContentMode = .fill) {
        self.imageUrl = imageUrl
        self.aspectRatio = aspectRatio
        self.contentMode = contentMode
    }

    var body: some View {
        defaultImage
            .opacity(uiImage == nil ? 1 : 0)
            .overlay {
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(aspectRatio, contentMode: contentMode)
                }
            }
            .overlay {
                if isLoading && uiImage == nil {
                    ProgressView()
                }
            }
            .task(id: imageUrl) {
                loadFromCache()
                if uiImage == nil {
                    await download()
                }
            }
    }

    private var defaultImage: some View {
        Image.cardBackside.moonShadow
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

// MARK: - Loading
extension CustomAsyncImage {
    private func loadFromCache() {
        guard uiImage == nil else { return }
        if let cached = ImageCacheManager.shared.loadImage(for: imageUrl) {
            uiImage = cached
        }
    }

    @MainActor
    private func download() async {
        guard uiImage == nil, !isLoading else { return }
        guard let url = URL(string: imageUrl) else { return }

        isLoading = true

        do {
            let (data, _) = try await Self.session.data(from: url)
            if let downloaded = UIImage(data: data) {
                ImageCacheManager.shared.saveImage(data, for: imageUrl)
                uiImage = downloaded
            }
        } catch {
            print("CustomAsyncImage: failed to download \(imageUrl) — \(error.localizedDescription)")
        }

        isLoading = false
    }
}
