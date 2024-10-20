//
//  CustomCardList.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

// MARK: - Cards Custom List
struct CardsCustomList: View {
    @ObservedObject var vm: CardsViewModel
    @Binding var isGestureEnabled: Bool
    
    @State private var swipedCardID: String? = nil
    
    var body: some View {
        LazyVStack(spacing: 15) {
            forEachSection { arkan, cardsForSection in
                Section(header: ArkanTitleView(text: arkan.plural)) {
                    if !cardsForSection.isEmpty {
                        cardsInSection(cardsForSection)
                    } else {
                        NoCardView(text: vm.noCardText)
                    }
                }
                Spacer(minLength: 7)
            }
            .tabTransition(
                previousTab: vm.previousTab.order,
                currentTab: vm.activeTab.order
            )
        }
    }

    @ViewBuilder
    private func forEachSection(@ViewBuilder completion: @escaping (Arcana, [Card]) -> some View) -> some View {
        switch vm.activeTab {
        case .all:
            ForEach(Arcana.allCases.filter { $0 != .all }, id: \.self) { arkan in
                if let cardsForSection = vm.presentedCards[arkan] {
                    completion(arkan, cardsForSection)
                }
            }
        case .major:
            if let cardsForSection = vm.presentedCards[vm.activeTab] {
                completion(vm.activeTab, cardsForSection)
            }
        case .minor:
            if let cardsForSection = vm.presentedCards[vm.activeTab] {
                completion(vm.activeTab, cardsForSection)
            }
        case .court:
            if let cardsForSection = vm.presentedCards[vm.activeTab] {
                completion(vm.activeTab, cardsForSection)
            }
        }
    }
    
    @ViewBuilder
    private func cardsInSection(_ cardsForSection: [Card]) -> some View {
        ForEach(cardsForSection, id: \.id) { card in
            let isDisabled = !isGestureEnabled && swipedCardID != card.id
            let vmCell = CardCellViewModel(card: card, vm)
            
            Button(action: { cardPressed(card) }) {
                SwipeableCardCellView(
                    vm: vmCell,
                    isGestureEnabled: $isGestureEnabled,
                    swipedCardID: $swipedCardID,
                    cellHeight: 150
                )
                .id(card.id)
            }
            .allowsHitTesting(isGestureEnabled)
            .onDisappear { refreshUIAfterSwiping(card) }
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.6 : 1)
            .animation(.easeInOut, value: isDisabled)
        }
    }
    
    private func refreshUIAfterSwiping(_ card: Card) {
        if swipedCardID == card.id {
            isGestureEnabled = true
            swipedCardID = nil
        }
    }
    
    private func cardPressed(_ card: Card) {
#warning("New Screen when tapped")
        print("Card \(card.title) pressed")
    }
}

fileprivate struct ArkanTitleView: View {
    let text: String
    
    var body: some View {
        Text(text.uppercased())
            .foregroundStyle(Color.main.secondaryText)
            .font(.title2)
            .fontDesign(.rounded)
            .fontWeight(.semibold)
    }
}
