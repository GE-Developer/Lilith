//
//  Card.swift
//  Lilith
//
//  Created by GE-Developer
//

struct Card: Identifiable, Decodable, Hashable {
    let id: String
    let order: Int?
    let imageUrl: String?
    let title: String?
    let numerology: Numerology?
    let astrology: Astrology?
    let element: TitledID?
    let archetype: TitledID?
    let sections: [TitledDescriptions]?
    let positiveAspects: TitledDescriptions?
    let negativeAspects: TitledDescriptions?

}

struct Numerology: Decodable, Hashable {
    let title: String?
    let number: String?
    let descriptions: [String]?
}

struct Astrology: Decodable, Hashable {
    let title: String?
    let planetId: String?
    let zodiacId: String?
}

struct TitledDescriptions: Decodable, Hashable {
    let title: String?
    let descriptions: [String]?
}

struct TitledID: Decodable, Hashable {
    let title: String?
    let id: String?
}
