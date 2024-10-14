//
//  CustomCardList.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Cards Custom List
struct CardsCustomList: View {
    @ObservedObject var vm: CardsViewModel
    @Binding var isGestureEnabled: Bool
    @State private var swipedCardID: String? = nil
    

    var body: some View {
        LazyVStack(spacing: 15) {
            ForEachSection { arkan, cardsForSection in
                Spacer(minLength: 7)
                Section(header: ArkanTitleView(text: arkan.plural)) {
                    if !cardsForSection.isEmpty {
                        ForEach(cardsForSection, id: \.id) { card in
                            
                            let isDisabled = !isGestureEnabled && swipedCardID != card.id
                            Button(action: { print("Нажатие на карту")  }) {
                                
                                let vmCell = CardCellViewModel(card: card, vm)
                                SwipeableCardCellView(
                                    vm: vmCell,
                                    cellHeight: 150,
                                    isGestureEnabled: $isGestureEnabled,
                                    swipedCardID: $swipedCardID
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
    private func ForEachSection(@ViewBuilder completion: @escaping (Arcana, [Card]) -> some View) -> some View {
        
        switch vm.activeTab {
        case .all:
            ForEach(Arcana.allCases.filter { $0 != .all }, id: \.self) { arkan in
                if let cardsForSection = vm.presentedCards[arkan] {
                    completion(arkan, cardsForSection)
                }
            }
//        default:
//            if let cardsForSection = cards[activeTab] {
//                completion(activeTab, cardsForSection)
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



//struct TabTransitionModifier: ViewModifier {
//    let previousTab: Int
//    let currentTab: Int
//
//    func body(content: Content) -> some View {
//        let isForward = previousTab < currentTab
//
//        let insertionEdge: Edge = isForward ? .trailing : .leading
//        let removalEdge: Edge = isForward ? .leading : .trailing
//        
//        let transition: AnyTransition = .asymmetric(
//            insertion: .move(edge: insertionEdge),
//            removal: .move(edge: removalEdge)
//        )
//        
//        return content
//            .transition(transition.combined(with: .opacity))
//    }
//}
//
//extension View {
//    func tabTransition(previousTab: Int, currentTab: Int) -> some View {
//        let viewModifier = TabTransitionModifier(
//            previousTab: previousTab,
//            currentTab: currentTab
//        )
//        return self.modifier(viewModifier)
//    }
//}
