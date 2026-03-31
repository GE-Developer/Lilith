//
//  LilithApp.swift
//  Lilith
//
//  Created by GE-Developer
//  26.08.2024

import SwiftUI

@main
struct LilithApp: App {
    private let themeManager = ThemeManager.shared
    private let dataService = JSONDataService.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if dataService.data != nil {
                    NavigationStack {
                        HomeView()
                    }
                } else if let error = dataService.loadError {
                    LoadingErrorView(message: error) {
                        Task { await dataService.load() }
                    }
                } else {
                    LoadingView()
                }
            }
            .preferredColorScheme(themeManager.isThemeLight ? .light : .dark)
            .task { await dataService.load() }
        }
    }
}

// MARK: - Loading View

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.main.background.ignoresSafeArea()
            VStack(spacing: 24) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                ProgressView()
                    .tint(Color.main.text)
            }
        }
    }
}

// MARK: - Loading Error View

struct LoadingErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        ZStack {
            Color.main.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                Image.system.wifiSlash
                    .font(.largeTitle)
                    .foregroundStyle(Color.main.secondaryText)

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(Color.main.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Button(action: onRetry) {
                    Text(L10n("UI.retry"))
                        .font(.body.weight(.medium))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.main.text.opacity(0.1))
                        .clipShape(Capsule())
                }
                .foregroundStyle(Color.main.text)
            }
        }
    }
}
