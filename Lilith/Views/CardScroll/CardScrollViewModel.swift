//
//  CardScrollViewModel.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 12.09.24.
//

import Foundation

final class CardScrollViewModel: ObservableObject {
    
    @Published var searchText = ""   
    @Published var activeTab: Arkan = .all
    @Published var placeholderText = "Поиск карты"
    @Published var searchedCards: [Card] = []
    
    var groupedCards: [Arkan : [Card]] {
        Dictionary(grouping: cards, by: { $0.arkan })
    }
    
    let title = "Колода Таро"
    
//    private let fullPlaceholder = "Поиск карты"
    private let cards: [Card]
    
    init(cards: [Card]) {
        self.cards = cards
//        startTypingAnimation()
    }
    
    deinit {
            print("SearchViewModel deinitialized")
        }
    
//    private func startTypingAnimation() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            var characterIndex = 0
//            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [unowned self] timer in
//                if characterIndex < self.fullPlaceholder.count {
//                    let index = self.fullPlaceholder.index(self.fullPlaceholder.startIndex, offsetBy: characterIndex)
//                    self.placeholderText.append(self.fullPlaceholder[index])
//                    characterIndex += 1
//                } else {
//                    timer.invalidate()
//                }
//            }
//        }
//    }
    
    func getSearched(_ cards: [Card]) -> [Card]? {
        guard searchText.count > 1 else { return cards }
        var newCards: [Card] = []
        
        for card in cards {
            let isTitleOK = card.title.uppercased().contains(searchText.uppercased())
            let isPlanetOK = card.astrology?.planet?.rawValue.uppercased().contains(searchText.uppercased()) ?? false
            let isZodiakOK = card.astrology?.zodiac?.rawValue.uppercased().contains(searchText.uppercased()) ?? false
            let isElementOK = card.element?.rawValue.uppercased().contains(searchText.uppercased()) ?? false
            
            if isTitleOK || isPlanetOK || isZodiakOK || isElementOK {
                newCards.append(card)
            }
        }
        
        if newCards.isEmpty {
            return nil
        }
        
        return newCards
    }
}
