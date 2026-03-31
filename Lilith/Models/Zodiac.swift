//
//  Zodiac.swift
//  Lilith
//
//  Created by GE-Developer
//

struct Zodiac: Identifiable, Decodable, Hashable {
    let id: String
    let name: String?
    let descriptions: [String]?
}
