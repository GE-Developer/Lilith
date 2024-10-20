//
//  CardsView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CardsView: View {
    @StateObject private var vm: CardsViewModel
    
    @State private var isGestureEnabled = true
    @State private var infoPresented = false
    
    init(_ typeOfDeck: CardsInfoProtocol) {
        _vm = StateObject(wrappedValue: CardsViewModel(typeOfDeck))
    }
    
    var body: some View {
        Group {
            CustomScrollView(headerHight: 90, type: .withSearchField) { isLarge in
                NavigationBarView(
                    infoPresented: $infoPresented,
                    title: vm.title,
                    subTitle: vm.subTitle,
                    isLarge: isLarge,
                    isGestureEnabled: isGestureEnabled,
                    cardCount: vm.countOfLikedCards
                )
            } headerView: { minY in
                HeaderView(vm: vm, minY: minY, isGestureEnabled: isGestureEnabled)
            } scrollView: {
                CardsCustomList(vm: vm, isGestureEnabled: $isGestureEnabled)
            }
        }
    }
}

fileprivate struct NavigationBarView: View {
    @Binding var infoPresented: Bool
    
    @State private var countBallIsPresented = false
    
    let title: String
    let subTitle: String
    let isLarge: Bool
    let isGestureEnabled: Bool
    let cardCount: String
    
    var body: some View {
        VStack(alignment: .leading) {
            mainTitle
            secondaryTitle
        }
        .fontDesign(.rounded)
        Spacer()
        infoButton
        likeButton
    }
    
    private var mainTitle: some View {
        Text(title)
            .font(isLarge ? .title : .title3)
            .fontWeight(.semibold)
            .foregroundStyle(Color.navigation.title)
    }
    
    private var secondaryTitle: some View {
        Group {
            if isLarge {
                Text(subTitle)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(Color.navigation.secondaryTitle)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
    
    private var likeButton: some View {
        Button(action: { print("Кнопка") }) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.likeButtonBackground)
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
        Button(action: { print("infoButton Pressed") }) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.likeButtonBackground)
                    .shadow(color: Color.main.viewShadow, radius: 5)
                Image(systemName: "info")
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
                        .foregroundStyle(Color.navigation.likeButtonBackground)
                        .shadow(color: Color.navigation.navBarShadow, radius: 2)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(Color.main.background)
                        }
                    Text(cardCount)
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
        .onChange(of: cardCount) { refreshCountBall($0, $1) }
    }
    
    private func refreshCountBall(_ oldValue: String, _ newValue: String) {
        guard newValue != "0" else { return countBallIsPresented = false }
        
        if oldValue == "0" {
            countBallIsPresented = true
        }
    }
}

fileprivate struct HeaderView: View {
    @ObservedObject var vm: CardsViewModel
    
    let minY: CGFloat
    let isGestureEnabled: Bool
    
    var body: some View {
        VStack {
            SearchView(
                searchText: $vm.searchText,
                placeholderText: vm.placeholderText,
                cancelButtonTitle: vm.cancelButtonTitle,
                minY: minY
            )
            .offset(y: min(minY / 2, 0))
            Spacer()
            SegmentedView(vm: vm)
                .offset(y: min(minY, 0))
        }
        .disabled(!isGestureEnabled)
        .opacity(isGestureEnabled ? 1 : 0.6)
        .animation(.easeInOut, value: isGestureEnabled)
    }
}
