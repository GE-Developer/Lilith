//
//  Planet.swift
//  Lilith
//
//  Created by GE-Developer
//

struct Planet: Identifiable, Decodable, Hashable {
    let id: String
    let name: String?
    let descriptions: [String]?
}
