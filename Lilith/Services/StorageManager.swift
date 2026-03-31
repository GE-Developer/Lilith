//
//  StorageManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation
import SwiftData

@MainActor
final class StorageManager {
    static let shared = try! StorageManager()
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    private init() throws {
        modelContainer = try ModelContainer(for: LikedCard.self)
        modelContext = modelContainer.mainContext
    }

    // MARK: - Create
    @discardableResult
    func create(id: String, deckID: String) async throws -> LikedCard {
        let likedCards = try await fetch(for: deckID)
        let maxOrder = likedCards.map { $0.order }.max() ?? 0
        let newCard = LikedCard(id, deckID, at: maxOrder + 1)
        modelContext.insert(newCard)
        try save()
        return newCard
    }

    // MARK: - Fetch
    func fetch(for deckID: String) async throws -> [LikedCard] {
        let descriptor = FetchDescriptor<LikedCard>(
            predicate: #Predicate { $0.deckID == deckID },
            sortBy: [SortDescriptor(\.order)]
        )
        return try modelContext.fetch(descriptor)
    }

    // MARK: - Delete
    func delete(ids: [String], deckID: String) async throws {
        guard !ids.isEmpty else { return }

        let descriptor = FetchDescriptor<LikedCard>(
            predicate: #Predicate { $0.deckID == deckID && ids.contains($0.id) }
        )
        let cards = try modelContext.fetch(descriptor)

        let foundIDs = cards.map(\.id)
        let notFound = Set(ids).subtracting(foundIDs)
        if !notFound.isEmpty {
            throw StorageError.notFound(ids: Array(notFound))
        }

        cards.forEach { modelContext.delete($0) }
        try save()
    }

    // MARK: - Delete All
    func deleteAll() async throws {
        let all = try modelContext.fetch(FetchDescriptor<LikedCard>())
        all.forEach { modelContext.delete($0) }
        try save()
    }

    // MARK: - Save
    private func save() throws {
        if modelContext.hasChanges {
            try modelContext.save()
        }
    }
}

// MARK: - Error Handling
enum StorageError: Error, LocalizedError {
    case notFound(ids: [String])
    
    var errorDescription: String? {
        switch self {
        case .notFound(let ids):
            return L10n("Error.cardsNotFound", ids.joined(separator: ", "))
        }
    }
}
