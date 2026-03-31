//
//  NetworkManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation
import Supabase

final class NetworkManager: Sendable {
    static let shared = NetworkManager()

    private let client: SupabaseClient

    private init() {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let urlString = dict["SUPABASE_URL"] as? String,
              let anonKey = dict["SUPABASE_ANON_KEY"] as? String,
              let url = URL(string: urlString)
        else {
            fatalError("Secrets.plist: SUPABASE_URL or SUPABASE_ANON_KEY missing")
        }

        client = SupabaseClient(supabaseURL: url, supabaseKey: anonKey)
    }

    // MARK: - Fetch Record from SQL

    func fetchRecord(for language: String) async throws -> AppDataRecord? {
        let response: [AppDataRecord] = try await client
            .from("app_data")
            .select("bucket, path, version")
            .eq("language", value: language)
            .limit(1)
            .execute()
            .value

        return response.first
    }

    // MARK: - Fetch Image Version from SQL

    func fetchImageVersion() async throws -> Int? {
        let response: [AppImageRecord] = try await client
            .from("app_images")
            .select("version")
            .limit(1)
            .execute()
            .value

        return response.first?.version
    }

    // MARK: - Download JSON from Storage

    func downloadJSON(bucket: String, path: String) async throws -> Data {
        do {
            return try await client.storage
                .from(bucket)
                .download(path: path)
        } catch {
            throw NetworkError.downloadFailed(path: "\(bucket)/\(path)")
        }
    }
}

// MARK: - Record Model

struct AppDataRecord: Decodable, Sendable {
    let bucket: String
    let path: String
    let version: Int
}

struct AppImageRecord: Decodable, Sendable {
    let version: Int
}
