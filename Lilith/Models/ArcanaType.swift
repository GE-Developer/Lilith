//
//  ArcanaType.swift
//  Lilith
//
//  Created by GE-Developer
//

struct ArcanaType: Identifiable, Decodable, Hashable {
    let id: String
    let order: Int?
    let pluralTitle: String?
    let singularTitle: String?
    let shortPluralTitle: String?
    let cards: [Card]?

}
