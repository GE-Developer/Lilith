//
//  CardCell.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CardCell: View {
    private let imageUrl: String
    private let title: String
    private let numerology: String?
    private let planet: Planet?
    private let zodiac: Zodiac?
    private let element: Element?
    private let archetype: String?
    private let isLiked: Bool

    private let cellHeight = 150.0

    init(imageUrl: String,
         title: String,
         numerology: String?,
         planet: Planet?,
         zodiac: Zodiac?,
         element: Element?,
         archetype: String?,
         isLiked: Bool) {
        self.imageUrl = imageUrl
        self.title = title
        self.numerology = numerology
        self.planet = planet
        self.zodiac = zodiac
        self.element = element
        self.archetype = archetype
        self.isLiked = isLiked
    }

    var body: some View {
        cardCell
    }
}

// MARK: - Builder
extension CardCell {
    private var cardCell: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Gradient.cellGradient)
            HStack(alignment: .top) {
                imageView

                VStack(alignment: .leading) {
                    HStack {
                        titleTextView
                        Spacer()
                        numerologyView
                    }
                    Divider()

                    VStack(alignment: .leading, spacing: 5) {
                        archetypeView
                        planetView
                        zodiacView
                        elementView
                    }
                }
                .padding(.top, 3)
                .padding(.horizontal, 3)
            }
            .padding(8)

            likeSymbolView
        }
    }

    private var imageView: some View {
        CustomAsyncImage(imageUrl: imageUrl, 2/3, .fit)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.main.background, lineWidth: 1)
            )
            .shadow(color: Color.main.viewShadow, radius: 3)
    }

    private var titleTextView: some View {
        Text(title.uppercased())
            .foregroundStyle(Color.main.text)
            .font(.subheadline)
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .minimumScaleFactor(0.5)
    }

    private var numerologyView: some View {
        ZStack {
            if let numerology {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 40, height: 20)
                    .foregroundStyle(Color.navigation.romanBackground)
                    .shadow(color: Color.sign.shadow, radius: 1)

                Text(numerology)
                    .foregroundStyle(Color.sign.romanText)
                    .font(.caption)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .padding(.vertical, 3)
            }
        }
        .frame(width: 41, height: 35)
    }

    private var planetView: some View {
        Group {
            if let planet {
                signView(title: planet.name ?? "") {
                    PlanetImage(planetName: planet.id, size: cellHeight / 12)
                }
            }
        }
    }

    private var zodiacView: some View {
        Group {
            if let zodiac {
                signView(title: zodiac.name ?? "") {
                    ZodiacImage(zodiac: zodiac.id, size: cellHeight / 12)
                }
            }
        }
    }

    private var elementView: some View {
        Group {
            if let element {
                signView(title: element.name ?? "") {
                    ElementImage(element: element.id, stroke: 1)
                }
            }
        }
    }

    private var archetypeView: some View {
        Group {
            if let archetype {
                signView(title: archetype) {
                    ArchetypeImage(size: cellHeight / 12)
                }
            }
        }
    }

    private var likeSymbolView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image.system.heartFill
                    .font(.title)
                    .foregroundStyle(Gradient.heartGradient)
                    .shadow(color: Color.main.background, radius: 3)
                    .opacity(isLiked ? 1 : 0)
            }
        }
        .padding()
    }

    @ViewBuilder
    private func signView<Sign: View>(title: String, @ViewBuilder sign: () -> Sign) -> some View {
        HStack {
            sign()
                .frame(width: cellHeight / 12, height: cellHeight / 12)
            Text(title.uppercased())
                .foregroundStyle(Color.main.secondaryText)
                .font(.caption2)
                .fontWeight(.medium)
                .fontDesign(.rounded)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.main.background)
        }
    }
}
