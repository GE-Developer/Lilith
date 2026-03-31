//
//  AppStorageKeys.swift
//  Lilith
//
//  Created by GE-Developer
//

enum AppStorageKey {
    case theme
    case haptics
    case language
    case sound
    case devPremium
    case earlyAccess
    case betaFeatures
    
    var key: String {
        switch self {
        case .theme: return "isThemeLight"
        case .haptics: return "isHapticsOff"
        case .language: return "AppleLanguages"
        case .sound: return "isSoundOff"
        case .devPremium: return "devPremium"
        case .earlyAccess: return "earlyAccess"
        case .betaFeatures: return "betaFeatures"
        }
    }
}
