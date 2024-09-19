//
//  CardCellViewModel.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 16.09.24.
//

import Foundation

final class CardCellViewModel: ObservableObject {
    
    @Published var isLiked: Bool = false
    
    var title: String {
        card.title.uppercased()
        
    }
    
    var imageName: String {
        card.image
    }
    
    var element: Element? {
        card.element
    }
    
    var planet: Planet? {
        card.astrology?.planet
    }
    
    var zodiac: Zodiac? {
        card.astrology?.zodiac
    }
    
    var romanNumber: String {
        card.numerology.romanNumber
    }
    
    private let card: Card
    
    init(card: Card) {
        self.card = card
    }
}
