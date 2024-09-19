//
//  CustomCardList.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Cards Custom List
struct CardsCustomList: View {
    
    /// View Properties
    @ObservedObject var vm: CardScrollViewModel

    
    /// Body
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEachCard { arkan, cards in
//                Spacer(minLength: 16)
                Section(header: ArkanTitleView(text: arkan.plural)) {
                    if let newCards = vm.getSearched(cards) {
                        ForEach(newCards) { card in
                            Button(action: { print("Нажатие") }) {
                                CardCellView(vm: CardCellViewModel(card: card), cellHeight: 130)
                            }
                        }
                    } else {
                        NoCardView()
                    }
                }
            }
        }
//        .safeAreaPadding(.horizontal)
//        .padding(.top)
    }
    
    @ViewBuilder
    private func ForEachCard(@ViewBuilder completion: @escaping (Arkan, [Card]) -> some View) -> some View {
        switch vm.activeTab {
        case .all:
            ForEach(Arkan.allCases, id: \.self) { arkan in
                if let cardsForSection = vm.groupedCards[arkan] {
                    completion(arkan, cardsForSection)
                }
            }
        default:
            if let cardsForSection = vm.groupedCards[vm.activeTab] {
                completion(vm.activeTab, cardsForSection)
            }
        }
    }
}

struct NoCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.clear, Color.main.background], startPoint: .bottom, endPoint: .top))
                .shadow(color: Color.main.zodiacShadow, radius: 5)
            Text("Нет карт")
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
        VStack {
            HStack {
                Circle()
                    .foregroundStyle(Color.main.cell)
                    .frame(width: 10)
                Spacer()
                Text(text)
                    .foregroundStyle(Color.main.secondaryText)
                    .font(.title2)
                    .fontDesign(.rounded)
                    .fontWeight(.light)
                Spacer()
                Circle()
                    .foregroundStyle(Color.main.cell)
                    .frame(width: 10)
            }
            Divider()
                .foregroundStyle(Color.main.cell)
        }
    }
}
