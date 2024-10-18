//
//  Arcana.swift
//  Lilith
//
//  Created by GE-Developer
//

enum Arcana: CaseIterable {
    case all
    case major
    case minor
    case court
    
    var singular: String {
        switch self {
        case .all: fatalError("This case (Arcana.all.singular) should not be used!")
        case .major: return L10n.Arcana.Singular.major
        case .minor: return L10n.Arcana.Singular.minor
        case .court: return L10n.Arcana.Singular.court
        }
    }
    
    var plural: String {
        switch self {
        case .all:   return L10n.Arcana.Plural.all
        case .major: return L10n.Arcana.Plural.major
        case .minor: return L10n.Arcana.Plural.minor
        case .court: return L10n.Arcana.Plural.court
        }
    }
    
    var shortPlural: String {
        switch self {
        case .all:   return L10n.Arcana.ShortPlural.all
        case .major: return L10n.Arcana.ShortPlural.major
        case .minor: return L10n.Arcana.ShortPlural.minor
        case .court: return L10n.Arcana.ShortPlural.court
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
