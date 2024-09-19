//
//  CardScrollView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 03.09.24.
//

import SwiftUI

struct CardScrollView: View {
    @StateObject private var vm = CardScrollViewModel(cards: Card.getCard())
    @FocusState private var isInputActive: Bool
    @State private var searchBarIsHidden = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
                        VStack {
                            SearchView(
                                searchText: $vm.searchText,
                                isInputActive: _isInputActive,
                                minY: minY,
                                isHidden: $searchBarIsHidden,
                                placeholderText: vm.placeholderText
                            )
                            .frame(height: 50)
                            .offset(y: minY < 0 ? -minY / 2 : -minY)
                            Spacer()
                            SegmentedView(activeTab: $vm.activeTab)
                                .offset(y: minY < 0 ? 0 : -minY)
                            Spacer()
                        }
                        .safeAreaPadding(.horizontal)
                    }
                    .frame(height: 110)
                    CardsCustomList(vm: vm)
                        .safeAreaPadding(.horizontal)
                }
                .scrollTargetBehavior(CustomScrollTargetBehaviour())
                .safeAreaPadding(.top, 170)
                .background(Color.main.background)
                
                TitleView(title: vm.title, isSmall: $searchBarIsHidden)
                    .safeAreaPadding(.horizontal)
                    .background {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundStyle(
                                Color.main.background
                                    .opacity(searchBarIsHidden ? 0.90 : 1)
                            )
                            .shadow(
                                color: Color.gray.opacity(0.7),
                                radius: searchBarIsHidden ? 5 : 0
                            )
                            .animation(.easeInOut, value: searchBarIsHidden)
                    }
                    .frame(height: searchBarIsHidden ? 120 : 150)
            }
            .ignoresSafeArea()
//            .background(Color.main.background)
        }
    }
}

// MARK: - Preview
#Preview {
    CardScrollView()
        .preferredColorScheme(.light)
}



struct CustomScrollTargetBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        switch target.rect.minY {
        case 0..<35:
            target.rect.origin = .zero
        case 35..<130:
            target.rect.origin = .init(x: 0, y: 90)
        case 130..<150:
            target.rect.origin = .init(x: 0, y: 160)
        default:
            break
        }
    }
}
