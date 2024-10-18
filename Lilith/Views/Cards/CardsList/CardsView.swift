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
    
    init(_ typeOfDeck: CardsInfoProtocol) {
        _vm = StateObject(wrappedValue: CardsViewModel(typeOfDeck))
    }
    
    var body: some View {
        CustomScrollView(headerHight: 90, type: .withSearchField) { isLarge in
            NavigationBarView(
                title: vm.title,
                subTitle: vm.subTitle,
                isLarge: isLarge,
                isGestureEnabled: isGestureEnabled
            )
        } headerView: { minY in
            HeaderView(vm: vm, minY: minY, isGestureEnabled: isGestureEnabled)
        } scrollView: {
            CardsCustomList(vm: vm, isGestureEnabled: $isGestureEnabled)
        }
    }
}

fileprivate struct NavigationBarView: View {
    let title: String
    let subTitle: String
    let isLarge: Bool
    let isGestureEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            mainTitle
            secondaryTitle
        }
        .fontDesign(.rounded)
        Spacer()
        //                Text(vm.likedCardIDs.count.formatted())
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
            }
        }
        .padding(.vertical, 8)
        .rotation3DEffect(
            Angle(degrees: isLarge ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.5), value: isLarge)
        .disabled(!isGestureEnabled)
        
        .opacity(isGestureEnabled ? 1 : 0.6)
        .animation(.easeInOut, value: isGestureEnabled)
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
