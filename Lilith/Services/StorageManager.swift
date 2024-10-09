//
//  StorageManager.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 09.10.24.
//

import SwiftData

final class StorageManager {
    @MainActor static let shared = StorageManager()
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    private let fetchDescriptor = FetchDescriptor<LikedCard>()
    
    @MainActor
    private init() {
        modelContainer = try! ModelContainer(for: LikedCard.self)
        modelContext = modelContainer.mainContext
    }
    
    // MARK: - Create
    func create(_ id: String, completion: (LikedCard) -> Void) {
        let newCard = LikedCard(id)
        modelContext.insert(newCard)
        save()
        completion(newCard)
    }
    
    // MARK: - Fetch Data
    func fetch(completion: (Result<[LikedCard], Error>) -> Void) {
        do {
            let likedCards = try modelContext.fetch(fetchDescriptor)
            completion(.success(likedCards))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Delete
    func delete(_ likedCard: LikedCard) {
        modelContext.delete(likedCard)
        save()
    }
    
    // MARK: - DeleteAll
    func deleteAll() {
        do {
            let allLikedCards = try modelContext.fetch(fetchDescriptor)
            allLikedCards.forEach { modelContext.delete($0) }
            save()
        } catch {
            print("Ошибка при удалении всех объектов: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Save
    func save() {
        if modelContext.hasChanges {
            do {
                try modelContext.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    }
}
