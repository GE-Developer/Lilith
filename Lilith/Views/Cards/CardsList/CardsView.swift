//
//  CardsView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 28.09.24.
//

import SwiftUI

struct CardsView: View {
    @StateObject var vm: CardsViewModel
    @State private var isGestureEnabled = true
    
    init(_ typeOfDeck: CardsInfoProtocol) {
        _vm = StateObject(wrappedValue: CardsViewModel(typeOfDeck))
    }
    
    var body: some View {
        Group {
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
                Text(vm.likedCardIDs.count.formatted())
                likeButton
                    .padding(.vertical, 8)
                    .rotation3DEffect(
                        Angle(degrees: isLarge ? 0 : 180),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.easeInOut(duration: 0.5), value: isLarge)
                    .disabled(!isGestureEnabled)
                
                    .opacity(isGestureEnabled ? 1 : 0.6)
                    .animation(.easeInOut, value: isGestureEnabled)
                
                
            } headerView: { minY in
                VStack {
                    SearchView(
                        searchText: $vm.searchText,
                        placeholderText: vm.placeholderText,
                        cancelButtonTitle: vm.cancelButtonTitle,
                        minY: minY
                    )
                    Spacer()
                    SegmentedView(vm: vm)
                }
                .disabled(!isGestureEnabled)
                .opacity(isGestureEnabled ? 1 : 0.6)
                .animation(.easeInOut, value: isGestureEnabled)
                
            } scrollView: {
                CardsCustomList(vm: vm, isGestureEnabled: $isGestureEnabled)
            }
        }
        .onDisappear {
            print("onDisappear")
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
    }
}
