//
//  CardsListViewModel.swift
//  Lilith
//
//  Created by GE-Developer.

import Foundation
import Combine

@MainActor
final class CardsViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var activeTab: Arkan = .all
    @Published var presentedCards: [Arkan: [Card]] = [:]
    
//    @Published var cellViewModels: [CardCellViewModel]
    
    private var cancellables = Set<AnyCancellable>()
    
    let title: String
    let subTitle: String
    let placeholderText = "Поиск карты"
    let cancelButtonTitle = "Отмена"
    
    init(_ cardData: CardsInfoProtocol) {
        title = cardData.title
        subTitle = cardData.subTitle
        sortCards(cards: Dictionary(grouping: cardData.cards, by: { $0.arkan }))
//        cellViewModels = presentedCards.map { CardCellViewModel(card: $0.value, storage: <#T##StorageManager#>) }
    }
    
    private func sortCards(cards: [Arkan: [Card]]) {        
        $searchText
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { [unowned self] newText in
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
    
    private func getSearchedCards(_ cards: [Arkan: [Card]], by text: String) -> [Arkan: [Card]] {
        var newCards: [Arkan: [Card]] = [:]
        
        cards.forEach { arkan, cards in
            let matchingCards = cards.filter { card in
                
                let isTitleOK = card.title.localizedCaseInsensitiveContains(text)
                let isPlanetOK = card.astrology?.planet?.rawValue
                    .localizedCaseInsensitiveContains(text) ?? false
                let isZodiacOK = card.astrology?.zodiac?.rawValue
                    .localizedCaseInsensitiveContains(text) ?? false
                let isElementOK = card.element?.rawValue
                    .localizedCaseInsensitiveContains(text) ?? false
                
                return isTitleOK || isPlanetOK || isZodiacOK || isElementOK
            }
            newCards[arkan] = matchingCards
        }
        return newCards
    }
}

