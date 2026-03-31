//
//  CacheManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

final class CacheManager: Sendable {
    static let shared = CacheManager()

    private let cacheDir: URL
    private let versionsKey = "cachedVersions"

    private init() {
        guard let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Application Support directory not found")
        }
        cacheDir = appSupport.appendingPathComponent("LilithCache", isDirectory: true)

        if !FileManager.default.fileExists(atPath: cacheDir.path) {
            try? FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true)
        }
    }

    // MARK: - Read

    func loadCachedData(for languageID: String) -> Data? {
        let fileURL = cacheDir.appendingPathComponent("\(languageID).json")
        return try? Data(contentsOf: fileURL)
    }

    func cachedVersion(for languageID: String) -> Int? {
        let versions = UserDefaults.standard.dictionary(forKey: versionsKey) as? [String: Int]
        return versions?[languageID]
    }

    // MARK: - Write

    func save(_ data: Data, for languageID: String, version: Int) throws {
        let fileURL = cacheDir.appendingPathComponent("\(languageID).json")
        try data.write(to: fileURL, options: .atomic)

        var versions = (UserDefaults.standard.dictionary(forKey: versionsKey) as? [String: Int]) ?? [:]
        versions[languageID] = version
        UserDefaults.standard.set(versions, forKey: versionsKey)
    }

    // MARK: - Delete

    func deleteCache(for languageID: String) throws {
        let fileURL = cacheDir.appendingPathComponent("\(languageID).json")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }

        var versions = (UserDefaults.standard.dictionary(forKey: versionsKey) as? [String: Int]) ?? [:]
        versions.removeValue(forKey: languageID)
        UserDefaults.standard.set(versions, forKey: versionsKey)
    }
}
