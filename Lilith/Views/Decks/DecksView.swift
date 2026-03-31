//
//  DeckView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct DecksView: View {
    @State private var vm = DecksViewModel()

    @State private var selectedDeckID: String?

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        decksView
            .navigationDestination(item: $selectedDeckID) { deckID in
                CardsView(deckID)
            }
    }
}

// MARK: - Logic
extension DecksView {
    private func deckPressed(_ deckID: String) {
        HapticsManager.shared.impact(style: .soft, vol: 0.6)
        selectedDeckID = deckID
    }
}

// MARK: - View Builder
extension DecksView {
    private var decksView: some View {
        CustomScrollView {
            CustomNavigationBar(title: vm.screenTitle, isLarge: $0)
            Spacer()
        } scrollView: {
            if vm.isLoading {
                CustomProgressView()
            } else {
                LazyVGrid(columns: columns) {
                    if let decks = vm.decks {
                        deckGrid(decks)
                    } else {
                        Text(L10n("Deck.noDecks"))
                    }
                }
            }
        }
        .task {
            vm.loadDecks()
        }
    }
    
    @ViewBuilder
    private func deckGrid(_ decks: [Deck]) -> some View {
        ForEach(decks, id: \.self) { deck in
            if (deck.isPublished ?? false) || vm.devBetaFeatures {
                deckCollumn(deck)
            }
        }
    }
    
    @ViewBuilder
    private func deckCollumn(_ deck: Deck) -> some View {
        VStack {
            Button(action: { deckPressed(deck.id) }) {
                deckImage(for: deck.imageUrl ?? "", (deck.isSoon ?? false) && !vm.devBetaFeatures)
            }
            deckTitle(for: deck.title ?? "", (deck.isSoon ?? false) && !vm.devBetaFeatures)
        }
        .disabled((deck.isSoon ?? false) && !vm.devEarlyAccess)
        .padding(.horizontal, 5)
        .padding(.bottom, 10)
    }
    
    
    @ViewBuilder
    func deckImage(for imageTitle: String, _ isSoon: Bool) -> some View {
        CustomAsyncImage(imageUrl: imageTitle, 2/3, .fit)
            .blur(radius: isSoon ? 2 : 0)
            .overlay(isSoon ? Color.home.overlay : Color.clear)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.main.background, lineWidth: 1)
            )
            .shadow(color: Color.main.viewShadow, radius: 3)
    }
    
    @ViewBuilder
    private func deckTitle(for deckTitle: String, _ isSoon: Bool) -> some View {
        VStack(spacing: 5) {
            Text(deckTitle)
                .foregroundStyle(Color.main.text)
                .font(.headline)
                .fontWeight(.medium)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
            
            Text(isSoon ? vm.soonTitle : "")
                .foregroundStyle(Color.main.secondaryText)
                .font(.subheadline)
                .fontWeight(.light)
            Spacer()
        }
        .frame(height: 65)
        .fontDesign(.rounded)
        .padding(.horizontal, 4)
    }
}

