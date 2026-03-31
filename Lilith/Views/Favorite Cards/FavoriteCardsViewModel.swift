//
//  FavoriteCardsViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@MainActor
@Observable
final class FavoriteCardsViewModel {
    var selectedCardIDs: [String] = []
    private(set) var likedCards: [Card]

    var likedCardsCount: Int {
        likedCards.count
    }
    var selectButtonTitle: String {
        let sortedIDs = likedCards
            .sorted { $0.id < $1.id }
            .map { $0.id }

        if sortedIDs.allSatisfy({ selectedCardIDs.contains($0) }) {
            return L10n("UI.deselectAll")
        } else {
            return L10n("UI.selectAll")
        }
    }
    var deleteSelectedButtonTitle: String {
        L10n("UI.delete") + (selectedCardIDs.isEmpty ? "" : " (\(selectedCardIDs.count))")
    }

    let title = L10n("Deck.favoriteTitle")
    let subTitle: String
    let noLikedCardsTitle = L10n("UI.noFavoriteCard")

    private let haptic = HapticsManager.shared
    private let deckID: String

    init(_ cards: [Card], subTitle: String = "", deckID: String) {
        self.likedCards = cards
        self.subTitle = subTitle
        self.deckID = deckID
    }

    func selectOrDeselectAll() {
        let sortedIDs = likedCards
            .sorted { $0.id < $1.id }
            .map { $0.id }

        if sortedIDs.allSatisfy({ selectedCardIDs.contains($0) }) {
            selectedCardIDs = []
        } else {
            selectedCardIDs = sortedIDs
        }
    }

    func deleteCards(ids: [String]) {
        Task {
            try? await StorageManager.shared.delete(ids: ids, deckID: deckID)
            likedCards.removeAll { ids.contains($0.id) }
            selectedCardIDs = []
        }
    }

    func cancelDeleting() {
        selectedCardIDs = []
        HapticsManager.shared.impact(style: .light)
    }
}
