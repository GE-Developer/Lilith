//
//  CustomCardList.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Cards Custom List
struct CardsCustomList: View {
    
    private let arkans = Arkan.allCases.filter { $0 != .all }
    
    let activeTab: Arkan
    let cards: [Arkan: [Card]]
    
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEachSection { arkan, cardsForSection in
                Section(header: ArkanTitleView(text: arkan.plural)) {
                    if !cardsForSection.isEmpty {
                        let _ = print(cardsForSection.isEmpty)
                        ForEach(cardsForSection) { card in
                            Button(action: { print("Нажатие") }) {
             
                                CardCellView(vm: CardCellViewModel(card: card, storage: .shared), cellHeight: 150)
                            
                            }
                            .disabled(false)
                        }
                    } else {
                        NoCardView()
                    }
                }
            }
            .transition(
                .asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                )
            )
        }
    }
    
//    private func determineTransition() -> AnyTransition {
//        if selectedCase.rawValue > previousCase.rawValue {
//            return .asymmetric(
//                insertion: .move(edge: .trailing).combined(with: .opacity),
//                removal: .move(edge: .leading).combined(with: .opacity)
//            )
//        } else {
//            return .asymmetric(
//                insertion: .move(edge: .leading).combined(with: .opacity),
//                removal: .move(edge: .trailing).combined(with: .opacity)
//            )
//        }
//    }
    
    @ViewBuilder
    private func ForEachSection(@ViewBuilder completion: @escaping (Arkan, [Card]) -> some View) -> some View {
        
        switch activeTab {
        case .all:
            ForEach(Arkan.allCases.filter { $0 != .all }, id: \.self) { arkan in
                if let cardsForSection = cards[arkan] {
                    completion(arkan, cardsForSection)
                }
            }
//        default:
//            if let cardsForSection = cards[activeTab] {
//                completion(activeTab, cardsForSection)
//            }
        case .major:
            if let cardsForSection = cards[activeTab] {
                completion(activeTab, cardsForSection)
            }
        case .minor:
            if let cardsForSection = cards[activeTab] {
                completion(activeTab, cardsForSection)
            }
        case .court:
            if let cardsForSection = cards[activeTab] {
                completion(activeTab, cardsForSection)
            }
        }
    }
}

struct NoCardView: View {
#warning("Цвет и NoCardView")
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [.clear, Color.red],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .shadow(color: Color.gray, radius: 5)
            Text("Нет карт")
                .font(.title3)
                .fontDesign(.rounded)
                .fontWeight(.light)
                .foregroundStyle(Color.gray)
        }
        .frame(height: 120)
    }
}

struct ArkanTitleView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundStyle(Color.main.titleText)
            .font(.title2)
            .fontDesign(.rounded)
            .fontWeight(.light)
    }
}

