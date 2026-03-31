//
//  NetworkError.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

enum NetworkError: LocalizedError {
    case languageNotFound(language: String)
    case downloadFailed(path: String)
    case decodingFailed(String)

    var errorDescription: String? {
        switch self {
        case .languageNotFound(let language):
            return "Language '\(language)' not found in app_data"
        case .downloadFailed(let path):
            return "Failed to download: \(path)"
        case .decodingFailed(let detail):
            return "JSON decoding failed: \(detail)"
        }
    }
}
