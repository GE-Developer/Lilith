//
//  CustomCardList.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Cards Custom List
struct CardsCustomList: View/*, Equatable*/ {
//    nonisolated static func == (lhs: CardsCustomList, rhs: CardsCustomList) -> Bool {
////        lhs.arkans == rhs.arkans
//        false
//    }
    

    
    /// View Properties
//    @ObservedObject var vm: CardScrollViewModel
    private let arkans = Arkan.allCases.filter { $0 != .all }
    
    let activeTab: Arkan
    let cards: [Arkan: [Card]]
    
//    var body: some View {
//        
//        LazyVStack(spacing: 15) {
//            ForEach(activeTab == .all ? arkans : [activeTab], id: \.self) { arkan in
//                Section(header: ArkanTitleView(text: arkan.plural)) {
//                    if let shownCards = cards[arkan] {
//                        let _ = print(shownCards.count)
//                        ForEach(shownCards) { card in
//                            CardCellView(vm: CardCellViewModel(card: card), cellHeight: 130)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    
    /// Body
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEachSection { arkan, cardsForSection in
                Spacer(minLength: 16)
                Section(header: ArkanTitleView(text: arkan.plural)) {
                    if !cardsForSection.isEmpty {
                    let _ = print(cardsForSection.isEmpty)
                        ForEach(cardsForSection) { card in
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
    }
    
    @ViewBuilder
    private func ForEachSection(@ViewBuilder completion: @escaping (Arkan, [Card]) -> some View) -> some View {
        
        switch activeTab {
        case .all:
            ForEach(Arkan.allCases.filter { $0 != .all }, id: \.self) { arkan in
                if let cardsForSection = cards[arkan] {
                    completion(arkan, cardsForSection)
                }
            }
        default:
            if let cardsForSection = cards[activeTab] {
                completion(activeTab, cardsForSection)
            }
        }
    }
    
    
    
    
    
    
    // .filter { $0 != .all }
    
    
}
            
            
            
            
            
            
            
    
    
    
    
    
//    /// Body
//    var body: some View {
//        VStack(spacing: 15) {
//            ForEachSection { arkan, cardsForSection in
//                
//                Section(header: ArkanTitleView(text: arkan.plural)) {
//                    if let newCards = vm.getSearched(cardsForSection) {
//                        ForEach(newCards) { card in
//                            Button(action: { print("Нажатие") }) {
//                                CardCellView(vm: CardCellViewModel(card: card), cellHeight: 130)
//                            }
//                        }
//                        
//                    }
//                }
//                
//            }
//        }
//    }
//    
//    @ViewBuilder
//    private func ForEachSection(@ViewBuilder completion: @escaping (Arkan, [Card]) -> some View) -> some View {
//        Spacer(minLength: 16)
//        
//        switch vm.activeTab {
//        case .all:
//            ForEach(Arkan.allCases.filter { $0 != .all }, id: \.self) { arkan in
//                if let cardsForSection = vm.presentedCards[arkan] {
//                    completion(arkan, cardsForSection)
//                }
//            }
//        default:
//            if let cardsForSection = vm.presentedCards[vm.activeTab] {
//                completion(vm.activeTab, cardsForSection)
//            }
//        }
//    }

    
    
    
    
    

struct NoCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.clear, Color.main.red], startPoint: .bottom, endPoint: .top))
                .shadow(color: Color.main.zodiacShadow, radius: 5)
            Text("Нет карт")
                .font(.title3)
                .fontDesign(.rounded)
                .fontWeight(.light)
                .foregroundStyle(Color.main.secondaryText)
        }
        .frame(height: 120)
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
        .padding(.bottom)
    }
}

