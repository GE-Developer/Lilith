//
//  CardDetailViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

@MainActor
final class CardDetailViewModel {
    let title = L10n("Deck.cardDetailTitle")
    let subTitle: String
    let cardImageID: String
    let cardImageUrl: String

    let cardTitle: String
    let arcanaTitle: String

    let archetype: ArchetypeInfo?
    let element: ElementInfo?
    let astrology: AstrologyInfo?
    let numerology: NumerologyInfo?

    let sections: [TitledDescriptions]

    let positiveTitle: String
    let positiveDescriptions: [String]

    let negativeTitle: String
    let negativeDescriptions: [String]

    init(card: Card, arcanaTypeID: String, subTitle: String) {
        let dataService = JSONDataService.shared

        self.subTitle = subTitle
        cardImageID = card.id
        cardImageUrl = card.imageUrl ?? ""
        cardTitle = card.title ?? ""

        arcanaTitle = dataService.getArcanaType(id: arcanaTypeID)?.singularTitle ?? ""

        // Archetype
        if let archetypeID = card.archetype?.id,
           let archetypeData = dataService.getArchetype(id: archetypeID) {
            archetype = ArchetypeInfo(
                title: card.archetype?.title ?? "",
                name: archetypeData.name ?? "",
                description: archetypeData.description ?? ""
            )
        } else {
            archetype = nil
        }

        // Element
        if let elementID = card.element?.id,
           let elementData = dataService.getElement(id: elementID) {
            element = ElementInfo(
                id: elementID,
                title: card.element?.title ?? "",
                name: elementData.name ?? "",
                descriptions: elementData.descriptions ?? []
            )
        } else {
            element = nil
        }

        // Astrology
        let planet = card.astrology?.planetId.flatMap { dataService.getPlanet(id: $0) }
        let zodiac = card.astrology?.zodiacId.flatMap { dataService.getZodiac(id: $0) }
        if planet != nil || zodiac != nil {
            astrology = AstrologyInfo(
                title: card.astrology?.title ?? "",
                planetId: card.astrology?.planetId,
                planetName: planet?.name,
                planetDescriptions: planet?.descriptions,
                zodiacId: card.astrology?.zodiacId,
                zodiacName: zodiac?.name,
                zodiacDescriptions: zodiac?.descriptions
            )
        } else {
            astrology = nil
        }

        // Numerology
        if let num = card.numerology {
            numerology = NumerologyInfo(
                title: num.title ?? "",
                number: num.number ?? "",
                descriptions: num.descriptions ?? []
            )
        } else {
            numerology = nil
        }

        // Sections
        sections = card.sections ?? []

        // Polarity
        positiveTitle = card.positiveAspects?.title ?? ""
        positiveDescriptions = card.positiveAspects?.descriptions ?? []

        negativeTitle = card.negativeAspects?.title ?? ""
        negativeDescriptions = card.negativeAspects?.descriptions ?? []
    }
}

// MARK: - Info Types

extension CardDetailViewModel {

    struct ArchetypeInfo {
        let title: String
        let name: String
        let description: String
    }

    struct ElementInfo {
        let id: String
        let title: String
        let name: String
        let descriptions: [String]
    }

    struct AstrologyInfo {
        let title: String
        let planetId: String?
        let planetName: String?
        let planetDescriptions: [String]?
        let zodiacId: String?
        let zodiacName: String?
        let zodiacDescriptions: [String]?
    }

    struct NumerologyInfo {
        let title: String
        let number: String
        let descriptions: [String]
    }
}
