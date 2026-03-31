//
//  JSONDataService.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

// MARK: - Service

@Observable
@MainActor
final class JSONDataService {
    static let shared = JSONDataService()

    private(set) var data: JSONRoot?
    private(set) var isLoading = false
    private(set) var loadError: String?

    private var currentLoadTask: Task<Void, Never>?
    private let network = NetworkManager.shared
    private let cache = CacheManager.shared

    private init() {}

    // MARK: - Initial Load (App Launch)

    func load() async {
        isLoading = true
        loadError = nil
        defer { isLoading = false }

        let currentLang = LanguageManager.shared.currentLanguageID
        let englishLang = AppLanguage.english.id

        // 1. Try cache first — instant display
        let cached = decode(for: currentLang) ?? decode(for: englishLang)
        if let cached {
            data = cached
        }

        // 2. Sync versions in background (download if needed)
        async let currentResult: Void = syncLanguage(currentLang)
        async let englishResult: Void = syncLanguage(englishLang)
        async let imageResult: Void = ImageCacheManager.shared.syncIfNeeded()
        _ = try? await currentResult
        _ = try? await englishResult
        _ = await imageResult

        // 3. Reload from cache if sync updated something
        let fresh = decode(for: currentLang) ?? decode(for: englishLang)
        if let fresh {
            data = fresh
        }

        if data == nil {
            loadError = NetworkError.downloadFailed(path: "").localizedDescription
        }
    }

    // MARK: - Language Switch

    func reloadForLanguage(_ languageID: String) {
        currentLoadTask?.cancel()

        // Instant switch from cache
        if let cached = decode(for: languageID) {
            data = cached
        } else if let english = decode(for: AppLanguage.english.id) {
            data = english
        }

        // Background: sync version and update cache
        currentLoadTask = Task { [weak self] in
            guard let self else { return }
            try? await self.syncLanguage(languageID)
            guard !Task.isCancelled else { return }

            if let fresh = self.decode(for: languageID) {
                self.data = fresh
            }
        }
    }

    // MARK: - Clear

    func clearData() {
        data = nil
    }

    // MARK: - Getters

    func getDecks() -> [Deck] {
        data?.decks ?? []
    }

    func getDeck(id: String) -> Deck? {
        data?.decks.first { $0.id == id }
    }

    func getArchetype(id: String) -> Archetype? {
        data?.archetypes.first { $0.id == id }
    }

    func getPlanet(id: String) -> Planet? {
        data?.planets.first { $0.id == id }
    }

    func getElement(id: String) -> Element? {
        data?.elements.first { $0.id == id }
    }

    func getZodiac(id: String) -> Zodiac? {
        data?.zodiacs.first { $0.id == id }
    }

    func getArcanaType(id: String) -> ArcanaType? {
        data?.decks.flatMap { $0.arcanaTypes ?? [] }.first { $0.id == id }
    }

    // MARK: - Private

    private func syncLanguage(_ languageID: String) async throws {
        let record = try await network.fetchRecord(for: languageID)

        guard let record else { return }

        let localVersion = cache.cachedVersion(for: languageID)

        if localVersion == nil || record.version > (localVersion ?? 0) {
            try? cache.deleteCache(for: languageID)
            let jsonData = try await network.downloadJSON(bucket: record.bucket, path: record.path)
            try cache.save(jsonData, for: languageID, version: record.version)
        }
    }

    private func decode(for languageID: String) -> JSONRoot? {
        guard let data = cache.loadCachedData(for: languageID) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(JSONRoot.self, from: data)
    }
}

// MARK: - Root

struct JSONRoot: Decodable {
    let decks: [Deck]
    let archetypes: [Archetype]
    let planets: [Planet]
    let elements: [Element]
    let zodiacs: [Zodiac]
}

// MARK: - Errors

enum JSONDataError: LocalizedError {
    case dataNotLoaded

    var errorDescription: String? {
        switch self {
        case .dataNotLoaded: return "App data not loaded yet"
        }
    }
}
