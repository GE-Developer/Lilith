//
//  DecksViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@MainActor
@Observable
final class DecksViewModel {
    private(set) var isLoading = false

    private(set) var decks: [Deck]? = nil

    let screenTitle = L10n("Deck.decksTitle")
    let soonTitle = L10n("Deck.soon")

    let devPremium = DeveloperManager.shared.isPremium
    let devEarlyAccess = DeveloperManager.shared.isEarlyAccess
    let devBetaFeatures = DeveloperManager.shared.isBetaFeaturesAccess

    private let dataService = JSONDataService.shared

    init() {}

    func loadDecks() {
        guard decks == nil else { return }

        isLoading = true
        defer { isLoading = false }
        decks = dataService.getDecks()
            .sorted(by: { ($0.queueNumber ?? 0) < ($1.queueNumber ?? 0) })
    }
}
