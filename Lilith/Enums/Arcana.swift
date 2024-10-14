//
//  Arcana.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 11.10.24.
//

import Foundation

enum Arcana: String, Hashable, CaseIterable {
    case all
    case major = "Старший Аркан"
    case minor = "Младший Аркан"
    case court = "Придворный Аркан"
    
    var plural: String {
        switch self {
        case .major: return "Старшие Арканы"
        case .minor: return "Младшие Арканы"
        case .court: return "Придворные Арканы"
        case .all:   return "Все Арканы"
        }
    }
    
    var shortPlural: String {
        switch self {
        case .major: return "Старшие"
        case .minor: return "Младшие"
        case .court: return "Придворные"
        case .all:   return "Все"
        }
    }
    
    var order: Int {
        switch self {
        case .all: return 0
        case .major: return 1
        case .minor: return 2
        case .court: return 3
        }
    }
}
