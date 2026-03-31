//
//  DeckInfoViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

@MainActor
final class DeckInfoViewModel {
    let title = L10n("Deck.informationTitle")
    let subTitle: String
    let randomImageUrls: [String]

    let mainDescription: String
    let sections: [TitledDescriptions]

    init(deck: Deck, cardImageUrls: [String]) {
        subTitle = deck.title ?? ""
        randomImageUrls = cardImageUrls
        mainDescription = deck.description?.mainDescription ?? ""
        sections = deck.description?.sections ?? []
    }
}
