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
                Spacer(minLength: 7)
                Section(header: ArkanTitleView(text: arkan.plural)) {
                    if !cardsForSection.isEmpty {
                        ForEach(cardsForSection, id: \.id) { card in
                            
                            
                            let isDisabled = !isGestureEnabled && swipedCardID != card.id
                            let vmCell = CardCellViewModel(card: card, vm)
                            Button(action: { print("Нажатие на карту")  }) {
                                SwipeableCardCellView(
                                    vm: vmCell,
                                    isGestureEnabled: $isGestureEnabled,
                                    swipedCardID: $swipedCardID,
                                    cellHeight: 150
                                )
                                .id(card.id)
                                
                            }
                            .allowsHitTesting(isGestureEnabled)
                            .onDisappear {
                                if swipedCardID == card.id {
                                    isGestureEnabled = true
                                    swipedCardID = nil
                                }
                            }
                            .disabled(isDisabled)
                            .opacity(isDisabled ? 0.6 : 1)
                            .animation(.easeInOut, value: isDisabled)
                            
                        }
                        
                    } else {
                        NoCardView(text: vm.noCardText)
                    }
                }
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
//        default:
//            if let cardsForSection = vm.presentedCards[vm.activeTab] {
//                sectionView(for: vm.activeTab, completion: completion)
//            }
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
    private func sectionView(for arcana: Arcana, @ViewBuilder completion: @escaping (Arcana, [Card]) -> some View) -> some View {
        if let cardsForSection = vm.presentedCards[arcana] {
            completion(arcana, cardsForSection)
        }
    }
}



struct NoCardView: View {
    let text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Gradient.cellGradient)
            Text(text)
                .font(.title3)
                .fontDesign(.rounded)
                .fontWeight(.light)
                .foregroundStyle(Color.main.secondaryText)
        }
        .frame(height: 100)
    }
}

struct ArkanTitleView: View {
    let text: String
    var body: some View {
        Text(text.uppercased())
            .foregroundStyle(Color.main.secondaryText)
            .font(.title2)
            .fontDesign(.rounded)
            .fontWeight(.semibold)
    }
}
