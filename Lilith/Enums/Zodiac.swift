//
//  Zodiac.swift
//  Lilith
//
//  Created by GE-Developer
//

enum Zodiac: String {
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces
    
    var name: String {
        switch self {
        case .aries: return L10n.Zodiac.aries
        case .taurus: return L10n.Zodiac.taurus
        case .gemini: return L10n.Zodiac.gemini
        case .cancer: return L10n.Zodiac.cancer
        case .leo: return L10n.Zodiac.leo
        case .virgo: return L10n.Zodiac.virgo
        case .libra: return L10n.Zodiac.libra
        case .scorpio: return L10n.Zodiac.scorpio
        case .sagittarius: return L10n.Zodiac.sagittarius
        case .capricorn: return L10n.Zodiac.capricorn
        case .aquarius: return L10n.Zodiac.aquarius
        case .pisces: return L10n.Zodiac.pisces
        }
    }
}
