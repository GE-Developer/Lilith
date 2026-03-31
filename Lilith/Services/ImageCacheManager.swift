//
//  ImageCacheManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import UIKit

final class ImageCacheManager: Sendable {
    static let shared = ImageCacheManager()

    private let cacheDir: URL
    private let versionKey = "cachedImageVersion"
    nonisolated(unsafe) private let memoryCache = NSCache<NSString, UIImage>()

    private init() {
        guard let appSupport = FileManager.default.urls(
            for: .applicationSupportDirectory, in: .userDomainMask
        ).first else {
            fatalError("Application Support directory not found")
        }
        cacheDir = appSupport.appendingPathComponent("LilithImageCache", isDirectory: true)

        if !FileManager.default.fileExists(atPath: cacheDir.path) {
            try? FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true)
        }
    }

    // MARK: - Version

    var cachedVersion: Int? {
        let v = UserDefaults.standard.integer(forKey: versionKey)
        return v == 0 ? nil : v
    }

    func saveVersion(_ version: Int) {
        UserDefaults.standard.set(version, forKey: versionKey)
    }

    func syncIfNeeded() async {
        guard let serverVersion = try? await NetworkManager.shared.fetchImageVersion() else { return }

        let localVersion = cachedVersion

        if localVersion == nil || serverVersion > (localVersion ?? 0) {
            clearAll()
            saveVersion(serverVersion)
        }
    }

    // MARK: - Read

    func loadImage(for url: String) -> UIImage? {
        let key = url as NSString

        if let cached = memoryCache.object(forKey: key) {
            return cached
        }

        let file = cacheDir.appendingPathComponent(fileName(for: url))
        guard let data = try? Data(contentsOf: file),
              let image = UIImage(data: data) else { return nil }

        memoryCache.setObject(image, forKey: key)
        return image
    }

    // MARK: - Write

    func saveImage(_ data: Data, for url: String) {
        let file = cacheDir.appendingPathComponent(fileName(for: url))
        try? data.write(to: file, options: .atomic)

        if let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: url as NSString)
        }
    }

    // MARK: - Delete All

    func clearAll() {
        guard let files = try? FileManager.default.contentsOfDirectory(
            at: cacheDir, includingPropertiesForKeys: nil
        ) else { return }

        for file in files {
            try? FileManager.default.removeItem(at: file)
        }

        memoryCache.removeAllObjects()
        UserDefaults.standard.removeObject(forKey: versionKey)
    }

    // MARK: - Private

    private func fileName(for url: String) -> String {
        Data(url.utf8).base64EncodedString()
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "=", with: "")
    }
}
