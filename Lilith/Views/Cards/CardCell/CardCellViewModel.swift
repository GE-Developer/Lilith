//
//  CardCellViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@MainActor
@Observable
final class CardCellViewModel {
    var isLiked: Bool {
        cardsViewModel?.likedCardIDs.contains(cardID) ?? false
    }

    weak var cardsViewModel: CardsViewModel?

    let title: String
    let imageUrl: String
    let element: Element?
    let planet: Planet?
    let zodiac: Zodiac?
    let archetype: String?
    let numerology: String?
    let cardID: String

    init(_ cardsViewModel: CardsViewModel, card: Card) {
        let dataService = JSONDataService.shared

        self.cardsViewModel = cardsViewModel
        title = card.title ?? ""
        imageUrl = card.imageUrl ?? ""
        element = card.element?.id.flatMap { dataService.getElement(id: $0) }
        planet = card.astrology?.planetId.flatMap { dataService.getPlanet(id: $0) }
        zodiac = card.astrology?.zodiacId.flatMap { dataService.getZodiac(id: $0) }
        archetype = card.archetype?.id.flatMap { dataService.getArchetype(id: $0)?.name }
        numerology = card.numerology?.number
        cardID = card.id
    }

    func likeOrDislikeCard() async {
        if isLiked {
            await cardsViewModel?.deleteCard(ids: [cardID])
            HapticsManager.shared.impact(delay: 0.2)
        } else {
            await cardsViewModel?.addCard(id: cardID)
            HapticsManager.shared.notification(type: .success, delay: 0.2)
        }
    }
}
