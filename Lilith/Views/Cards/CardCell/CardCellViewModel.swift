//
//  CardCellViewModel.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 16.09.24.
//

import Foundation
import Combine

@MainActor
final class CardCellViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    unowned var cardsViewModel: CardsViewModel
    
    var isLiked = false
    
    let title: String
    let imageName: String
    let element: Element?
    let planet: Planet?
    let zodiac: Zodiac?
    let romanNumber: String
    let cardID: String
    
    init(card: Card, _ cardsViewModel: CardsViewModel) {
        title = card.title.uppercased()
        imageName = card.image
        element = card.element
        planet = card.astrology?.planet
        zodiac = card.astrology?.zodiac
        romanNumber = card.numerology.romanNumber
        self.cardsViewModel = cardsViewModel
        cardID = card.id
        
        bindIsLiked()
    }
    
    deinit {
        print("deinit --  \(title)")
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
