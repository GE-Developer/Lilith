//
//  CustomCardList.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

// MARK: - Cards Custom List

private struct CardNavItem: Hashable {
    let card: Card
    let arcanaTypeID: String
}

struct CardsCustomList: View {
    var vm: CardsViewModel
    @Binding var isGestureEnabled: Bool

    @State private var swipedCardID: String? = nil
    @State private var selectedNavItem: CardNavItem?

    var body: some View {
        Group {
            LazyVStack(spacing: 15) {
                Spacer(minLength: 10)
                forEachSection { arcanaName, arcanaTypeID, cards in

                    arcanaTitle(title: arcanaName)
                    if !cards.isEmpty {
                        cardsInSection(cards, arcanaTypeID: arcanaTypeID)
                    } else {
                        NoContentView(text: L10n("UI.noCards"), 100)
                    }

                    Spacer(minLength: 7)
                }
            }
        }
        .id(vm.activeTab)
        .navigationDestination(item: $selectedNavItem) { navItem in
            CardDetailView(
                card: navItem.card,
                arcanaTypeID: navItem.arcanaTypeID,
                subTitle: vm.subTitle ?? ""
            )
        }
    }

    @ViewBuilder
    private func forEachSection(@ViewBuilder completion: @escaping (String, String, [Card]) -> some View) -> some View {
        if let activeTabShort = vm.activeTab,
           let arcana = vm.arcanas.first(where: { $0.shortPluralTitle == activeTabShort }),
           let cards = vm.filteredCards[arcana.id] {
            completion(arcana.pluralTitle ?? "", arcana.id, cards)
        }
    }


    private func cardsInSection(_ cards: [Card], arcanaTypeID: String) -> some View {
        ForEach(cards) { card in
            let isDisabled = !isGestureEnabled && swipedCardID ?? "" != card.id
            let vmCell = CardCellViewModel(vm, card: card)

            Button(action: { cardPressed(card, arcanaTypeID: arcanaTypeID) }) {
                SwipeableCardCellView(
                    vm: vmCell,
                    isGestureEnabled: $isGestureEnabled,
                    swipedCardID: $swipedCardID
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

    private func cardPressed(_ card: Card, arcanaTypeID: String) {
        HapticsManager.shared.impact(style: .medium)
        selectedNavItem = CardNavItem(card: card, arcanaTypeID: arcanaTypeID)
    }

    private func arcanaTitle(title: String) -> some View {
        Text(title.uppercased())
            .foregroundStyle(Color.main.secondaryText)
            .font(.title2)
            .fontDesign(.rounded)
            .fontWeight(.semibold)
    }
}
