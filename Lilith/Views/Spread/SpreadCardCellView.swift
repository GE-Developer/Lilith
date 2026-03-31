//
//  SpreadCardCellView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SpreadCardCellView: View {
    private let card: Card
    private let position: Int

    init(card: Card, position: Int) {
        self.card = card
        self.position = position
    }

    var body: some View {
        cardCell
    }
}

// MARK: - Builder
extension SpreadCardCellView {
    private var cardCell: some View {
        HStack(alignment: .top, spacing: 12) {
            cardImage
            cardInfo
        }
        .padding(12)
        .background(cellBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.main.viewShadow, radius: 4, x: 0, y: 2)
    }

    private var cardImage: some View {
        CustomAsyncImage(imageUrl: card.imageUrl ?? "", 2/3, .fill)
            .frame(width: 72)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.main.viewShadow, radius: 3, x: 0, y: 2)
    }

    private var cardInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            positionLabel
            cardTitle
            signsRow
            metaText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var positionLabel: some View {
        Text(L10n("UI.Spread.cardPosition", position))
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundStyle(Color.main.secondaryText)
            .textCase(.uppercase)
    }

    private var cardTitle: some View {
        Text(card.title ?? "")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(Color.main.titleText)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private var signsRow: some View {
        let dataService = JSONDataService.shared
        HStack(spacing: 8) {
            if let elementId = card.element?.id, dataService.getElement(id: elementId) != nil {
                ElementImage(element: elementId, stroke: 1.5)
                    .frame(width: 14, height: 14)
            }
            if let planetId = card.astrology?.planetId {
                PlanetImage(planetName: planetId, size: 14)
            }
            if let zodiacId = card.astrology?.zodiacId {
                ZodiacImage(zodiac: zodiacId, size: 14)
            }
        }
    }

    @ViewBuilder
    private var metaText: some View {
        let dataService = JSONDataService.shared
        VStack(alignment: .leading, spacing: 2) {
            if let archetypeId = card.archetype?.id,
               let archetype = dataService.getArchetype(id: archetypeId) {
                Text(archetype.name ?? "")
                    .font(.caption)
                    .foregroundStyle(Color.sign.archtype)
                    .lineLimit(1)
            }
            if let numerology = card.numerology {
                Text(numerology.number ?? "")
                    .font(.caption)
                    .foregroundStyle(Color.main.secondaryText)
                    .lineLimit(1)
            }
        }
    }

    private var cellBackground: some View {
        LinearGradient(
            colors: [Color.navigation.cellOne, Color.navigation.cellTwo],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
