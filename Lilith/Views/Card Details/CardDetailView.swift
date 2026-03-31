//
//  CardDetailView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CardDetailView: View {
    @State private var isRotated = false

    private let vm: CardDetailViewModel
    private let headerHeight: Double = 350

    init(card: Card, arcanaTypeID: String, subTitle: String) {
        vm = CardDetailViewModel(card: card, arcanaTypeID: arcanaTypeID, subTitle: subTitle)
    }

    var body: some View {
        CustomScrollView(headerHight: headerHeight, type: .withLargeHeaderView) {
            CustomNavigationBar(title: vm.title, subTitle: vm.subTitle, isLarge: $0)
            Spacer()
            if $0 {
                rotateButton
                    .transition(.scale.combined(with: .opacity))
            }
        } headerView: { minY in
            CustomAsyncImage(imageUrl: vm.cardImageUrl, 3/5, .fit)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.main.background, lineWidth: 1)
                )
                .shadow(color: Color.main.viewShadow, radius: 3)
                .rotationEffect(isRotated ? Angle(degrees: 180) : .zero)
                .animation(.easeInOut, value: isRotated)
                .scaleEffect(min(max(1 + minY / headerHeight, 0), 1))
                .offset(y: min(minY / 2, 0))
                .opacity(
                    minY < -headerHeight / 2
                    ? max((minY + headerHeight) / 100.0, 0)
                    : 1
                )
                .padding()
        } scrollView: {
            LazyVStack(alignment: .leading, spacing: 16) {

                CardTitle(vm.cardTitle, vm.arcanaTitle)

                // Archetype View
                if let archetype = vm.archetype {
                    ArchetypeDescriptionView(archetype.title, archetype.name, archetype.description)
                }

                // Element View
                if let element = vm.element {
                    ElementDescriptionView(element.id, element.title, element.name, element.descriptions)
                }

                // Astrology View
                if let astrology = vm.astrology {
                    AstrologyDescriptionView(
                        astrology.title,
                        planetId: astrology.planetId,
                        planetName: astrology.planetName,
                        planetDescriptions: astrology.planetDescriptions,
                        zodiacId: astrology.zodiacId,
                        zodiacName: astrology.zodiacName,
                        zodiacDescriptions: astrology.zodiacDescriptions
                    )
                }

                // Numerology View
                if let numerology = vm.numerology {
                    NumerologyDescriptionView(numerology.number, numerology.descriptions, numerology.title)
                }

                // Sections
                ForEach(vm.sections, id: \.title) { section in
                    OtherDescriptionView(section.title ?? "", section.descriptions ?? [])
                }

                // Polarity View
                PolarityView(
                    vm.positiveTitle,
                    vm.negativeTitle,
                    vm.positiveDescriptions,
                    vm.negativeDescriptions
                )
            }
            .fontDesign(.rounded)
            .fontWeight(.light)
        }
        .scrollIndicators(.hidden)
    }

    private var rotateButton: some View {
        Button(action: { isRotated.toggle() } ) {
            ZStack {
                Circle()
                    .foregroundStyle(Color.navigation.buttonBackground)
                    .shadow(color: Color.main.viewShadow, radius: 5)

                Image.system.rotationImage
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Gradient.heartGradient)
                    .scaleEffect(0.5)
            }
            .aspectRatio(1/1, contentMode: .fit)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 6)
    }
}

fileprivate struct OtherDescriptionView: View {
    private let title: String
    private let descriptions: [String]

    init(_ title: String, _ descriptions: [String]) {
        self.title = title
        self.descriptions = descriptions
    }

    var body: some View {
        Divider()
            .padding(.bottom)
        TitleInDescriptionView(title: title)

        ForEach(descriptions, id: \.self) { description in
            HStack(alignment: .top) {
                Text("•")
                    .fontWeight( .bold)
                Text(description.asAttributedString())
            }
            .foregroundStyle(Color.main.text)
        }
    }
}

fileprivate struct VerticalLineText: View {
    private let title: String
    private let descriptions: [String]

    init(_ title: String, _ descriptions: [String]) {
        self.title = title
        self.descriptions = descriptions
    }

    var body: some View {
        Divider()
            .padding(.bottom)
        TitleInDescriptionView(title: title)

        ForEach(descriptions, id: \.self) { description in
            HStack {
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: 2)
                Text(description.asAttributedString())
                    .padding(.leading, 6)
                Spacer()
            }
            .padding(.vertical, 6)
            .foregroundStyle(Color.main.text)
        }
        .padding(.horizontal, 4)
    }
}

fileprivate struct PolarityView: View {
    private let positiveTitle: String
    private let negativeTitle: String
    private let positiveDescriptions: [String]
    private let negativeDescriptions: [String]

    init(_ positiveTitle: String, _ negativeTitle: String, _ positiveDescriptions: [String], _ negativeDescriptions: [String]) {
        self.positiveTitle = positiveTitle
        self.negativeTitle = negativeTitle
        self.positiveDescriptions = positiveDescriptions
        self.negativeDescriptions = negativeDescriptions
    }

    var body: some View {
        TabView {
            if !positiveDescriptions.isEmpty {
                polarityTabView(title: positiveTitle, polDescriptions: positiveDescriptions)
            }
            if !negativeDescriptions.isEmpty {
                polarityTabView(title: negativeTitle, polDescriptions: negativeDescriptions)
            }
        }
        .frame(height: 250)
        .tabViewStyle(.page)
    }

    @ViewBuilder
    private func polarityTabView(title: String, polDescriptions: [String]) -> some View {
        VStack {
            Divider()
                .padding(.bottom)
            TitleInDescriptionView(title: title)
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1.5)
                    .foregroundStyle(Color.navigation.title)
                    .opacity(0.5)
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(polDescriptions, id: \.self) { description in
                            HStack(alignment: .top) {
                                Text("•")
                                    .fontWeight( .bold)
                                Text(description.asAttributedString())
                            }
                            .foregroundStyle(Color.main.text)
                        }
                    }
                }
                .padding(10)
                .scrollIndicators(.hidden)
            }
            Color.main.background
                .frame(height: 40)
        }
        .padding(.horizontal, 8)
        .padding(.top, 3)
    }
}

fileprivate struct CardTitle: View {
    private let title: String
    private let arcanaTitle: String

    init(_ title: String, _ arcanaTitle: String) {
        self.title = title
        self.arcanaTitle = arcanaTitle
    }

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 10) {
                Text(title.uppercased())
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundStyle(Color.navigation.title)
                    .multilineTextAlignment(.center)
                Text(arcanaTitle.uppercased())
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundStyle(Color.main.secondaryText)
            }
            Spacer()
        }
    }
}

fileprivate struct ArchetypeDescriptionView: View {
    private let title: String
    private let archetype: String
    private let description: String

    init(_ title: String, _ archetype: String, _ description: String) {
        self.title = title
        self.archetype = archetype
        self.description = description
    }

    var body: some View {
        Divider()
            .padding(.bottom)
        HStack {
            TitleInDescriptionView(title: title)
            Spacer()
            archetypeIcon
        }
        Text(description.asAttributedString())
            .foregroundStyle(Color.main.text)
    }

    private var archetypeIcon: some View {
        HStack(spacing: 6) {
            ArchetypeImage(size: 16)
            Text(archetype.uppercased())
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.main.text)
        }
        .padding(5)
        .elementBackground()
    }
}

fileprivate struct ElementDescriptionView: View {
    private let id: String
    private let title: String
    private let name: String
    private let descriptions: [String]

    init(_ id: String, _ title: String, _ name: String, _ descriptions: [String]) {
        self.id = id
        self.title = title
        self.name = name
        self.descriptions = descriptions
    }

    var body: some View {
        Divider()
            .padding(.bottom)
        HStack {
            TitleInDescriptionView(title: title)
            Spacer()
            elementIcon
        }
        ForEach(descriptions, id: \.self) { description in
            HStack(alignment: .top) {
                Text("•")
                    .fontWeight(.bold)
                Text(description.asAttributedString())
            }
        }
        .foregroundStyle(Color.main.text)
    }

    private var elementIcon: some View {
        HStack(spacing: 6) {
            ElementImage(element: id, stroke: 1)
                .frame(width: 16, height: 16)
            Text(name.uppercased())
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.main.text)
        }
        .padding(5)
        .elementBackground()
    }
}

fileprivate struct AstrologyDescriptionView: View {
    private let title: String
    private let planetId: String?
    private let planetName: String?
    private let planetDescriptions: [String]?
    private let zodiacId: String?
    private let zodiacName: String?
    private let zodiacDescriptions: [String]?

    init(_ title: String, planetId: String?, planetName: String?, planetDescriptions: [String]?, zodiacId: String?, zodiacName: String?, zodiacDescriptions: [String]?) {
        self.title = title
        self.planetId = planetId
        self.planetName = planetName
        self.planetDescriptions = planetDescriptions
        self.zodiacId = zodiacId
        self.zodiacName = zodiacName
        self.zodiacDescriptions = zodiacDescriptions
    }

    var body: some View {
        Divider()
            .padding(.bottom)
        HStack {
            titleView
            Spacer()
            planet
            zodiac
        }
        planetDescription
        zodiacDescription
    }

    private var titleView: some View {
        Text(title)
            .fontWeight(.bold)
            .font(.title3)
            .foregroundStyle(Color.navigation.title)
            .minimumScaleFactor(0.5)
    }

    private var planet: some View {
        Group {
            if let planetName {
                HStack(spacing: 6) {
                    if let planetId {
                        PlanetImage(planetName: planetId, size: 16)
                    }
                    Text(planetName.uppercased())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.main.text)
                }
                .padding(5)
                .elementBackground()
            }
        }
    }

    private var zodiac: some View {
        Group {
            if let zodiacName {
                HStack(spacing: 6) {
                    if let zodiacId {
                        ZodiacImage(zodiac: zodiacId, size: 16)
                    }
                    Text(zodiacName.uppercased())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.main.text)
                }
                .padding(5)
                .elementBackground()
            }
        }
    }

    private var planetDescription: some View {
        HStack {
            if let planetDescriptions {
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: 2)
                    .foregroundStyle(Color.sign.planet)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(planetDescriptions, id: \.self) { description in
                        HStack(alignment: .top) {
                            Text("•")
                                .fontWeight(.bold)
                            Text(description.asAttributedString())
                        }
                    }
                    .foregroundStyle(Color.main.text)

                }
                Spacer()
            }
        }
    }

    private var zodiacDescription: some View {
        HStack {
            if let zodiacDescriptions {
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: 2)
                    .foregroundStyle(Color.sign.zodiac)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(zodiacDescriptions, id: \.self) { description in
                        HStack(alignment: .top) {
                            Text("•")
                                .fontWeight(.bold)
                            Text(description.asAttributedString())
                        }
                    }
                    .foregroundStyle(Color.main.text)

                }
                Spacer()
            }
        }
    }
}

fileprivate struct NumerologyDescriptionView: View {
    private let romanNum: String
    private let descriptions: [String]
    private let numTitle: String

    init(_ romanNumber: String, _ descriptions: [String], _ numTitle: String) {
        self.romanNum = romanNumber
        self.descriptions = descriptions
        self.numTitle = numTitle
    }

    var body: some View {
        Divider()
            .padding(.bottom)
        HStack {
            title
            Spacer()
            romanNumber
        }
        description
    }

    private var title: some View {
        Text(numTitle)
            .fontWeight(.bold)
            .font(.title3)
            .foregroundStyle(Color.navigation.title)
            .minimumScaleFactor(0.5)
    }

    private var romanNumber: some View {
        Text(romanNum)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundStyle(Color.main.text)
            .padding(5)
            .padding(.horizontal, 20)
            .elementBackground()
    }

    private var description: some View {
        ForEach(descriptions, id: \.self) { description in
            HStack(alignment: .top) {
                Text("•")
                    .fontWeight(.bold)
                Text(description.asAttributedString())
            }
            .foregroundStyle(Color.main.text)
        }
    }
}

fileprivate struct TitleInDescriptionView: View {
    let title: String

    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .font(.title3)
            .foregroundStyle(Color.navigation.title)
            .minimumScaleFactor(0.5)
    }
}
