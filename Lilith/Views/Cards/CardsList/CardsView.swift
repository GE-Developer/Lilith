//
//  CardsView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CardsView: View {
    @State private var vm: CardsViewModel

    @State private var isGestureEnabled = true
    @State private var infoPresented = false
    @State private var showFavorites = false
    @State private var showDeckInfo = false

    init(_ DeckID: String) {
        _vm = State(wrappedValue: CardsViewModel(deckID: DeckID))
    }

    var body: some View {
        Group {
            CustomScrollView(headerHight: 90, type: .withSearchField) { isLarge in
                CustomNavigationBar(
                    title: vm.title,
                    subTitle: vm.subTitle ,
                    isLarge: isLarge
                )
                Spacer()
                NavigationButtons(
                    infoPresented: $infoPresented,
                    showFavorites: $showFavorites,
                    showDeckInfo: $showDeckInfo,
                    vm: vm,
                    isLarge: isLarge,
                    isGestureEnabled: isGestureEnabled
                )
            } headerView: { minY in
                HeaderView(vm: vm, minY: minY, isGestureEnabled: isGestureEnabled)
            } scrollView: {
                switch vm.loadingState {
                case .idle, .loading:
                    CustomProgressView()
                case .success:
                    CardsCustomList(vm: vm, isGestureEnabled: $isGestureEnabled)
                case .failure:
                    NoContentView(text: L10n("UI.Spread.error"), 150)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: vm.loadingState)
        }
        .navigationDestination(isPresented: $showFavorites) {
            NavigationLazyView(FavoriteCardsView(vm.getLikedCards(), subTitle: vm.subTitle ?? "", deckID: vm.deckID))
        }
        .sheet(isPresented: $showDeckInfo) {
            if let deck = vm.deck {
                DeckInfoView(deck: deck, cardImageUrls: vm.getRandomCardImageUrls())
            }
        }
        .task {
            vm.loadCards()
        }
        .onChange(of: showFavorites) { _, newValue in
            if !newValue {
                Task { await vm.refreshLikedCards() }
            }
        }
    }
}

fileprivate struct NavigationButtons: View {
    @Binding var infoPresented: Bool
    @Binding var showFavorites: Bool
    @Binding var showDeckInfo: Bool
    var vm: CardsViewModel

    @State private var countBallIsPresented = false

    let isLarge: Bool
    let isGestureEnabled: Bool
    
    var body: some View {
        infoButton
        likeButton
    }
    
    private var likeButton: some View {
        Button(action: likeViewButtonPressed) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.buttonBackground)
                    .shadow(color: Color.main.viewShadow, radius: 5)
                Image.system.heartFill
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Gradient.heartGradient)
                    .offset(y: 1)
                    .scaleEffect(0.5)
                countBall
            }
            .aspectRatio(1/1, contentMode: .fit)
        }
        .padding(.vertical, isLarge ? 16 : 8)
        .padding(.horizontal, 6)
        .disabled(!isGestureEnabled)
        .opacity(isGestureEnabled ? 1 : 0.6)
        .animation(.easeInOut, value: isGestureEnabled)
    }
    
    private var infoButton: some View {
        Button(action: infoViewButtonPressed) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.buttonBackground)
                    .shadow(color: Color.main.viewShadow, radius: 5)
                Image.system.info
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Gradient.heartGradient)
                    .scaleEffect(0.4)
            }
            .aspectRatio(1/1, contentMode: .fit)
        }
        .padding(.vertical, isLarge ? 16 : 8)
        .opacity(isLarge ? isGestureEnabled ? 1 : 0.6 : 0)
        .scaleEffect(isLarge ? 1 : 0.001)
        .disabled(!isGestureEnabled)
        .animation(.easeInOut, value: isGestureEnabled)
    }
    
    private var countBall: some View {
        HStack {
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .foregroundStyle(Color.navigation.buttonBackground)
                        .shadow(color: Color.navigation.navBarShadow, radius: 2)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(Color.main.background)
                        }
                    Text(vm.countOfLikedCards)
                        .foregroundStyle(Color.main.secondaryText)
                        .font(.system(size: 12, weight: .heavy, design: .rounded))
                }
                .frame(width: isLarge ? 20 : 18, height: isLarge ? 20 : 18)
            }
            Spacer()
        }
        .offset(x: -8)
        .opacity(countBallIsPresented ? 1 : 0)
        .scaleEffect(countBallIsPresented ? 1 : 0.001)
        .animation(.easeOut, value: countBallIsPresented)
        .onChange(of: vm.countOfLikedCards) { refreshCountBall($0, $1) }
    }
    
    private func refreshCountBall(_ oldValue: String, _ newValue: String) {
        guard newValue != "0" else { return countBallIsPresented = false }
        
        if oldValue == "0" {
            countBallIsPresented = true
        }
    }
    
    private func likeViewButtonPressed() {
        showFavorites = true
    }

    private func infoViewButtonPressed() {
        showDeckInfo = true
    }
}

fileprivate struct HeaderView: View {
    @Bindable var vm: CardsViewModel
    
    let minY: CGFloat
    let isGestureEnabled: Bool
    
    var body: some View {
        VStack {
            CustomNavigationTextField(
                text: $vm.searchText,
                minY: minY,
                image: .system.magnifyingglass,
                placeholder: vm.placeholderText,
                cancelButtonTitle: vm.cancelButtonTitle,
                deleteAction: vm.deleteText
            )
            .offset(y: min(minY / 2, 0))
            Spacer()
            TextSegments(activeTab: $vm.activeTab, tabs: vm.arcanas.compactMap { $0.shortPluralTitle })
                .offset(y: min(minY, 0))
                .animation(nil, value: vm.loadingState)
        }
        .disabled(!isGestureEnabled)
        .opacity(isGestureEnabled ? 1 : 0.6)
        .animation(.easeInOut, value: isGestureEnabled)
    }
}
