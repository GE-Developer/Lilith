//
//  CardsView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 28.09.24.
//

import SwiftUI

struct CardsView: View {
    @StateObject private var vm = CardsViewModel(ClassicCard())
    
    var body: some View {
        CustomScrollView(headerHight: 90, type: .withSearchField) { isLarge in
            VStack(alignment: .leading) {
                Text(vm.title)
                    .font(isLarge ? .title : .title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.navigation.title)
                if isLarge {
                    Text(vm.subTitle)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundStyle(Color.navigation.secondaryTitle)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .fontDesign(.rounded)
            Spacer()
            likeButton
                .padding(.vertical, 8)
                .rotation3DEffect(
                    Angle(degrees: isLarge ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.easeInOut(duration: 0.5), value: isLarge)
            
        } headerView: { minY in
            VStack {
                SearchView(
                    searchText: $vm.searchText,
                    placeholderText: vm.placeholderText,
                    cancelButtonTitle: vm.cancelButtonTitle,
                    minY: minY
                )
                Spacer()
                SegmentedView(activeTab: $vm.activeTab)
            }
            
        } scrollView: {
            CardsCustomList(activeTab: vm.activeTab, cards: vm.presentedCards)
        }
    }
    
    private var likeButton: some View {
        Button(action: { print("Переход на страницу лайков") }) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.likeButtonBackground)
                    .shadow(color: Color.main.viewShadow, radius: 5)
                Image.system.heartFill
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(
                        RadialGradient(
                            colors: [
                                Color.navigation.heartOne,
                                Color.navigation.heartTwo
                            ],
                            center: .bottomTrailing,
                            startRadius: 0,
                            endRadius: 90
                        )
                    )
                    .offset(y: 1)
                    .scaleEffect(0.5)
            }
        }
    }
}
