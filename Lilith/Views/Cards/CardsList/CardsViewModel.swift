//
//  CardsViewModel.swift
//  Lilith
//
//  Created by GE-Developer

import Foundation
import Combine

@MainActor
final class CardsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var activeTab: Arcana = .all {
        didSet {
            HapticsManager.shared.selectionChanged()
            previousTab = oldValue
        }
    }
    @Published private(set) var presentedCards: [Arcana: [Card]] = [:]
    @Published private(set) var likedCardIDs: [String] = [] {
        didSet {
            likedCardCount()
        }
    }
    private(set) var countOfLikedCards = ""
    private(set) var previousTab: Arcana = .all
    
    private var cancellables = Set<AnyCancellable>()
    
    let title: String
    let subTitle: String
    let placeholderText = L10n.Ui.searchCard
    let cancelButtonTitle = L10n.Ui.cancel
    let noCardText = L10n.Ui.noCard
    
    private let cards: [Arcana: [Card]]
    private let allCardsCount: Int
    private let deckID: String
    
    init(_ cardData: CardsInfoProtocol) {
        cards = Dictionary(grouping: cardData.cards, by: { $0.arkan })
        title = cardData.title
        subTitle = cardData.subTitle
        deckID = cardData.id
        allCardsCount = cardData.cards.count
        sortCards(cards: cards)
        fetchLikedCards()
        likedCardCount()
    }
    
    func countAllCards(for arcana: Arcana) -> String {
        switch arcana {
        case .all:
            return "(\(allCardsCount))"
        default:
            return "(\(cards[arcana]?.count ?? 0))"
        }
    }
    
    func fetchLikedCards() {
        StorageManager.shared.fetch(for: deckID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let likedCards):
                likedCardIDs = likedCards.map { $0.id }
            case .failure(let error):
                print("Ошибка при загрузке лайкнутых карт: \(error.localizedDescription)")
            }
        }
    }
    
    func addCard(id: String) {
        StorageManager.shared.create(id: id, deckID: deckID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newCard):
                likedCardIDs.append(newCard.id)
            case .failure(let error):
                print("Ошибка при добавлении карты: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCard(ids: [String]) {
        StorageManager.shared.delete(ids: ids, deckID: deckID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                likedCardIDs.removeAll { ids.contains($0) }
            case .failure(let error):
                print("Ошибка при удалении карт: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteText() {
        searchText = ""
        HapticsManager.shared.impact(style: .rigid)
    }
    
    private func sortCards(cards: [Arcana: [Card]]) {
        $searchText
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] newText in
                guard let self = self else { return }
                if newText.count < 2 {
                    self.presentedCards = cards
                } else {
                    Task {
                        let updatedCards = self.getSearchedCards(cards, by: newText)
                        self.presentedCards = updatedCards
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func getSearchedCards(_ cards: [Arcana: [Card]], by text: String) -> [Arcana: [Card]] {
        var newCards: [Arcana: [Card]] = [:]
        
        cards.forEach { arkan, cards in
            let matchingCards = cards.filter { card in
                
                let isTitleOK = card.title.localizedCaseInsensitiveContains(text)
                let isPlanetOK = card.astrology?.planet?.name
                    .localizedCaseInsensitiveContains(text) ?? false
                let isZodiacOK = card.astrology?.zodiac?.name
                    .localizedCaseInsensitiveContains(text) ?? false
                let isElementOK = card.element?.name
                    .localizedCaseInsensitiveContains(text) ?? false
                
                return isTitleOK || isPlanetOK || isZodiacOK || isElementOK
            }
            newCards[arkan] = matchingCards
        }
        return newCards
    }
    
    private func likedCardCount() {
        countOfLikedCards = likedCardIDs.count.formatted()
    }
}
