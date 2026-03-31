//
//  Deck.swift
//  Lilith
//
//  Created by GE-Developer
//

struct Deck: Identifiable, Decodable, Hashable {
    let id: String
    let title: String?
    let imageUrl: String?
    let queueNumber: Int?
    let price: Int?
    let isSoon: Bool?
    let isPublished: Bool?
    let description: DeckDescription?
    let arcanaTypes: [ArcanaType]?
}

struct DeckDescription: Decodable, Hashable {
    let mainDescription: String?
    let sections: [TitledDescriptions]?
}
