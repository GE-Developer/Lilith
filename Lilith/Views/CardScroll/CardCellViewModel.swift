//
//  CardCellViewModel.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 16.09.24.
//

import Foundation

final class CardCellViewModel: ObservableObject {
    
    @Published var isLiked: Bool = false
    
    let title: String
    let imageName: String
    let element: Element?
    let planet: Planet?
    let zodiac: Zodiac?
    let romanNumber: String
    
    private let card: Card
    
    init(card: Card) {
        self.card = card
        title = card.title.uppercased()
        imageName = card.image
        element = card.element
        planet = card.astrology?.planet
        zodiac = card.astrology?.zodiac
        romanNumber = card.numerology.romanNumber
    }
}
