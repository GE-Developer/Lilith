//
//  StorageManager.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 09.10.24.
//

import Foundation
import SwiftData

@MainActor
final class StorageManager {
    static let shared = StorageManager()
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    private init() {
        do {
            modelContainer = try ModelContainer(for: LikedCard.self)
            modelContext = modelContainer.mainContext
        } catch {
            fatalError("Не удалось инициализировать ModelContainer: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Create
    func create(id: String, deckID: String, completion: @escaping (Result<LikedCard, Error>) -> Void) {
        Task {
            do {
                let predicate: Predicate<LikedCard> = #Predicate { $0.deckID == deckID }
                let fetchDescriptor = FetchDescriptor<LikedCard>(predicate: predicate)
                let likedCardIDs = try modelContext.fetch(fetchDescriptor)
                let currentMaxOrder = likedCardIDs.map { $0.order }.max() ?? 0
                let newLikedCard = LikedCard(id, deckID, at: currentMaxOrder + 1)
                modelContext.insert(newLikedCard)
                save()
                completion(.success(newLikedCard))
            } catch {
                print("Ошибка при создании LikedCard: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch Data
    func fetch(for deckID: String, completion: @escaping (Result<[LikedCard], Error>) -> Void) {
        Task {
            do {
                let sortDescriptor = SortDescriptor<LikedCard>(\.order, order: .forward)
                let predicate: Predicate<LikedCard> = #Predicate { $0.deckID == deckID }
                let fetchDescriptor = FetchDescriptor<LikedCard>(
                    predicate: predicate,
                    sortBy: [sortDescriptor]
                )
                let likedCards = try modelContext.fetch(fetchDescriptor)
                completion(.success(likedCards))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Delete
    func delete(ids: [String], deckID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            guard !ids.isEmpty else {
                completion(.success(()))
                return
            }
            
            let predicate: Predicate<LikedCard> = #Predicate {
                $0.deckID == deckID && ids.contains($0.id)
            }
            let fetchDescriptor = FetchDescriptor<LikedCard>(predicate: predicate)
            
            do {
                let likedCards = try modelContext.fetch(fetchDescriptor)
                likedCards.forEach { modelContext.delete($0) }
                try modelContext.save()
                
                let foundIDs = likedCards.map { $0.id }
                let notFoundIDs = Set(ids).subtracting(foundIDs)
                
                if notFoundIDs.isEmpty {
                    completion(.success(()))
                } else {
                    let errorMessage = "Не удалось найти LikedCard с id: \(notFoundIDs.joined(separator: ", "))"
                    let error = NSError(
                        domain: "StorageManager",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: errorMessage]
                    )
                    completion(.failure(error))
                }
            } catch {
                print("Ошибка при удалении LikedCards: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - DeleteAll
    func deleteAll(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            let fetchDescriptor = FetchDescriptor<LikedCard>()
            
            do {
                let allLikedCards = try modelContext.fetch(fetchDescriptor)
                allLikedCards.forEach { modelContext.delete($0) }
                save()
                completion(.success(()))
            } catch {
                print("Ошибка при удалении всех объектов: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Save
    private func save() {
        if modelContext.hasChanges {
            do {
                try modelContext.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    }
}
