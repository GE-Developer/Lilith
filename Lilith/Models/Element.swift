//
//  Element.swift
//  Lilith
//
//  Created by GE-Developer
//

struct Element: Identifiable, Decodable, Hashable {
    let id: String
    let name: String?
    let descriptions: [String]?
}
