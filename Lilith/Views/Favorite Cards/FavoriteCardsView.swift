//
//  FavoriteCardsView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct FavoriteCardsView: View {
    @State private var vm: FavoriteCardsViewModel
    @State private var isDeleting = false

    private let cellHeight = 150.0

    init(_ cards: [Card], subTitle: String = "", deckID: String) {
        _vm = State(wrappedValue: FavoriteCardsViewModel(cards, subTitle: subTitle, deckID: deckID))
    }

    var body: some View {
        ZStack {
            CustomScrollView { isLarge in
                FavoriteCardsNavigationBarView(
                    vm: vm,
                    isDeleting: $isDeleting,
                    isLarge: isLarge
                )
            } scrollView: {
                if !vm.likedCards.isEmpty {
                    likedCardsList
                } else {
                    NoContentView(text: vm.noLikedCardsTitle, cellHeight)
                        .transition(
                            .asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .identity
                            )
                        )
                }
            }
            .animation(.default, value: vm.likedCards)
            deletingCapsule
        }
    }

    private var likedCardsList: some View {
        LazyVStack {
            ForEach(vm.likedCards) { card in
                let dataService = JSONDataService.shared
                let planet = card.astrology?.planetId.flatMap { dataService.getPlanet(id: $0) }
                let zodiac = card.astrology?.zodiacId.flatMap { dataService.getZodiac(id: $0) }
                let element = card.element?.id.flatMap { dataService.getElement(id: $0) }
                let archetype = card.archetype?.id.flatMap { dataService.getArchetype(id: $0)?.name }

                ZStack {
                    Button {
                        cardPressed(card)
                    } label: {
                        CardCell(
                            imageUrl: card.imageUrl ?? "",
                            title: card.title ?? "",
                            numerology: card.numerology?.number,
                            planet: planet,
                            zodiac: zodiac,
                            element: element,
                            archetype: archetype,
                            isLiked: true
                        )
                        .frame(height: cellHeight)
                    }
                    .id(card.id)

                    HStack(spacing: 0) {
                        Spacer()
                        Group {
                            if vm.selectedCardIDs.contains(card.id) {
                                Image.system.chechmark
                                    .resizable()
                                    .foregroundStyle(Color.navigation.heartOne)
                            } else {
                                Image.system.circle
                                    .resizable()
                                    .foregroundStyle(Color.navigation.cellOne)
                            }
                        }
                        .scaleEffect(isDeleting ? 1 : 0)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: cellHeight / 6)
                    }
                    .offset(x: cellHeight / 8 + 16)
                }
                .onTapGesture { cardPressed(card) }
                .transition(.asymmetric(insertion: .identity, removal: .scale.combined(with: .opacity)))
            }
            Spacer(minLength: isDeleting ? cellHeight / 2.5 + 20 : 0)
        }
        .offset(x: isDeleting ? -40 : 0)
    }

    private var deletingCapsule: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    withAnimation {
                        vm.deleteCards(ids: vm.selectedCardIDs)
                        isDeleting.toggle()
                    }
                } label: {
                    Spacer()
                    Text(vm.deleteSelectedButtonTitle)
                    Spacer()
                }
                .foregroundStyle(vm.selectedCardIDs.isEmpty ? Color.main.titleText : Color.home.destructive)
                .disabled(vm.selectedCardIDs.isEmpty)
                .opacity(vm.selectedCardIDs.isEmpty ? 0.4 : 1)

                Divider()

                Button(action: selectOrDeselect) {
                    Spacer()
                    Text(vm.selectButtonTitle)
                    Spacer()
                }
                .foregroundStyle(Color.main.titleText)
                Divider()

                Button {
                    vm.cancelDeleting()
                    withAnimation {
                        isDeleting.toggle()
                    }
                } label: {
                    Image.system.xmark
                        .padding(.leading, 20)
                        .padding(.trailing, 30)
                }
                .foregroundStyle(Color.main.titleText)
            }
            .font(.subheadline)
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .frame(height: cellHeight / 3.5)
            .padding(.vertical)
            .background {
                Capsule()
                    .foregroundStyle(Color.main.background)
                    .opacity(0.95)
                    .shadow(color: Color.main.viewShadow, radius: 5)
            }
        }
        .padding(.horizontal)
        .offset(y: isDeleting ? 10 : 120)
    }

    private func cardPressed(_ card: Card) {
        switch isDeleting {
        case true:
            if vm.selectedCardIDs.contains(card.id) {
                vm.selectedCardIDs.removeAll { $0 == card.id }
            } else {
                vm.selectedCardIDs.append(card.id)
            }
        default:
            HapticsManager.shared.impact(style: .soft, vol: 0.6)
        }
    }

    private func selectOrDeselect() {
        withAnimation(nil) {
            vm.selectOrDeselectAll()
        }
    }
}

fileprivate struct FavoriteCardsNavigationBarView: View {
    var vm: FavoriteCardsViewModel
    @Binding var isDeleting: Bool

    let isLarge: Bool

    var body: some View {
        VStack(alignment: .leading) {
            mainTitle
            secondaryTitle
        }
        .fontDesign(.rounded)
        Spacer()
        deleteButton
    }

    private var mainTitle: some View {
        Text(vm.title)
            .font(isLarge ? .title : .title3)
            .fontWeight(.semibold)
            .foregroundStyle(Color.navigation.title)
    }

    private var secondaryTitle: some View {
        Group {
            if isLarge {
                Text(vm.subTitle)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(Color.navigation.secondaryTitle)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private var deleteButton: some View {
        Button(action: deleteOptionPressed) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.buttonBackground)
                    .shadow(color: Color.main.viewShadow, radius: 5)

                Image.system.binFill
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Gradient.heartGradient)
                    .scaleEffect(0.5)
            }
            .aspectRatio(1/1, contentMode: .fit)
        }
        .padding(.vertical, isLarge ? 16 : 8)
        .padding(.horizontal, 6)
        .opacity(vm.likedCardsCount == 0 ? 0.6 : 1)
        .disabled(vm.likedCardsCount == 0)
        .animation(.easeInOut, value: vm.likedCardsCount == 0)
    }

    private func deleteOptionPressed() {
        vm.cancelDeleting()
        withAnimation {
            isDeleting.toggle()
        }
    }
}
