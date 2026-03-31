//
//  CardsViewModel.swift
//  Lilith
//
//  Created by GE-Developer

import Foundation

@MainActor
@Observable
final class CardsViewModel {

    let deckID: String
    let placeholderText = L10n("UI.searchCard")
    let cancelButtonTitle = L10n("UI.cancel")
    let title = L10n("Deck.title")
    let noCardText = L10n("UI.noCard")

    var loadingState: LoadingState = .idle
    var activeTab: String?
    var searchText: String = "" {
        didSet { filterCards() }
    }

    private(set) var subTitle: String? = nil
    private(set) var deck: Deck?
    private(set) var arcanas: [ArcanaType] = []
    private(set) var filteredCards: [String: [Card]] = [:]
    private(set) var likedCardIDs: [String] = []

    var countOfLikedCards: String {
        likedCardIDs.count.formatted()
    }

    private let dataService = JSONDataService.shared
    private var originalCards: [String: [Card]] = [:]

    init(deckID: String) {
        self.deckID = deckID
    }

    func deleteText() {
        searchText = ""
        HapticsManager.shared.impact(style: .rigid)
    }

    func getRandomCardImageUrls(count: Int = 3) -> [String] {
        originalCards
            .flatMap { $0.value }
            .shuffled()
            .prefix(count)
            .compactMap { $0.imageUrl }
    }

    func loadCards() {
        if case .success = loadingState {
            return
        }

        loadingState = .loading

        guard let deck = dataService.getDeck(id: deckID) else {
            loadingState = .failure
            return
        }

        self.deck = deck
        self.subTitle = deck.title

        let sortedArcanas = (deck.arcanaTypes ?? []).sorted { ($0.order ?? 0) < ($1.order ?? 0) }

        var groupedCards: [String: [Card]] = [:]
        for arcana in sortedArcanas {
            groupedCards[arcana.id] = (arcana.cards ?? []).sorted { ($0.order ?? 0) < ($1.order ?? 0) }
        }

        self.arcanas = sortedArcanas
        self.originalCards = groupedCards
        self.filteredCards = groupedCards
        self.activeTab = sortedArcanas.first?.shortPluralTitle

        Task { await fetchLikedCards() }

        loadingState = .success
    }

    func addCard(id: String) async {
        do {
            let newCard = try await StorageManager.shared.create(id: id, deckID: deckID)
            likedCardIDs.append(newCard.id)
        } catch { }
    }

    func deleteCard(ids: [String]) async {
        do {
            try await StorageManager.shared.delete(ids: ids, deckID: deckID)
            likedCardIDs.removeAll { ids.contains($0) }
        } catch { }
    }

    func getLikedCards() -> [Card] {
        originalCards
            .flatMap { $0.value }
            .filter { likedCardIDs.contains($0.id) }
    }

    func refreshLikedCards() async {
        await fetchLikedCards()
    }

    private func fetchLikedCards() async {
        do {
            let likedCards = try await StorageManager.shared.fetch(for: deckID)
            self.likedCardIDs = likedCards.map { $0.id }
        } catch { }
    }

    private func filterCards() {
        let cleanText = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        if cleanText.count < 2 {
            filteredCards = originalCards
            return
        }

        var updated: [String: [Card]] = [:]

        for (arcanaID, cards) in originalCards {
            let filtered = cards.filter { card in
                let title = (card.title ?? "").lowercased()
                let planet = card.astrology?.planetId
                    .flatMap { dataService.getPlanet(id: $0)?.name?.lowercased() } ?? ""
                let zodiac = card.astrology?.zodiacId
                    .flatMap { dataService.getZodiac(id: $0)?.name?.lowercased() } ?? ""
                let element = card.element?.id
                    .flatMap { dataService.getElement(id: $0)?.name?.lowercased() } ?? ""
                let archetype = card.archetype?.id
                    .flatMap { dataService.getArchetype(id: $0)?.name?.lowercased() } ?? ""

                return title.contains(cleanText)
                || planet.contains(cleanText)
                || zodiac.contains(cleanText)
                || element.contains(cleanText)
                || archetype.contains(cleanText)
            }

            updated[arcanaID] = filtered
        }

        filteredCards = updated
    }
}
