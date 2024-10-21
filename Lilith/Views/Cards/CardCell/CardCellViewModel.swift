//
//  CardCellViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation
import Combine

@MainActor
final class CardCellViewModel: ObservableObject {
    unowned var cardsViewModel: CardsViewModel
    
    private(set) var isLiked = false
    private var cancellables = Set<AnyCancellable>()
    
    let title: String
    let element: Element?
    let planet: Planet?
    let zodiac: Zodiac?
    let romanNumber: String
    let cardID: String
    
    init(card: Card, _ cardsViewModel: CardsViewModel) {
        self.cardsViewModel = cardsViewModel
        title = card.title.uppercased()
        element = card.element
        planet = card.astrology?.planet
        zodiac = card.astrology?.zodiac
        romanNumber = card.numerology.romanNumber
        cardID = card.id
        
        bindIsLiked()
    }
    
    func likeOrDislikeCard() {
        if isLiked {
            cardsViewModel.deleteCard(ids: [cardID])
            HapticsManager.shared.impact(delay: 0.2)
        } else {
            cardsViewModel.addCard(id: cardID)
            HapticsManager.shared.notification(type: .success, delay: 0.2)
        }
    }
    
    private func bindIsLiked() {
        cardsViewModel.$likedCardIDs
            .map { [weak self] likedCardIDs in
                guard let self = self else { return false }
                return likedCardIDs.contains(self.cardID)
            }
            .sink { [weak self] isLiked in
                self?.isLiked = isLiked  // Обновляем состояние вручную, без assign
            }
            .store(in: &cancellables)
    }
}
