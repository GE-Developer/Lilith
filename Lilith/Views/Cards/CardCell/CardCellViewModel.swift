//
//  CardCellViewModel.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 16.09.24.
//

import Foundation

final class CardCellViewModel: ObservableObject {
    
    private var storage: StorageManager
    @Published private var likedCards: [LikedCard] = [] {
        didSet {
            let liked = likedCards.contains(where: { $0.id == card.id })
            isLiked = liked
        }
    }
    
    @Published var isLiked = false
    @Published var isLikeButtonShow = false
    
    let title: String
    let imageName: String
    let element: Element?
    let planet: Planet?
    let zodiac: Zodiac?
    let romanNumber: String
    
    private let card: Card
    
    deinit {
        print("Deinit")
    }
    
    init(card: Card, storage: StorageManager) {
        self.card = card
        title = card.title.uppercased()
        imageName = card.image
        element = card.element
        planet = card.astrology?.planet
        zodiac = card.astrology?.zodiac
        romanNumber = card.numerology.romanNumber
        self.storage = storage
        
        fetch()
    }
    
    private func fetch() {
        storage.fetch { result in
            switch result {
            case .success(let likedCards):
                self.likedCards = likedCards
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func create() {
        storage.create(card.id) { newCard in
            likedCards.append(newCard)
        }
    }
    
    func delete() {
        if let likedCard = likedCards.first(where: { $0.id == card.id }) {
            // Если такая карта найдена, вызываем метод удаления
            storage.delete(likedCard)
            
            // Можно также удалить карту из массива likedCards (если нужно)
            likedCards.removeAll { $0.id == card.id }
        } else {
            print("Карта с id \(card.id) не найдена в likedCards.")
        }
    }
}
