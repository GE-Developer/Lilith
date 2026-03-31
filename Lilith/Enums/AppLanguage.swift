//
//  AppLanguage.swift
//  Lilith
//
//  Created by GE-Developer
//

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case georgian = "ka"
    case russian = "ru"
    case german = "de"
    case french = "fr"
    case spanish = "es"
    case italian = "it"
    
    var id: String { rawValue }
    
    var localizedName: String {
        switch self {
        case .english: return "English"
        case .georgian: return "ქართული"
        case .russian: return "Русский"
        case .german: return "Deutsch"
        case .french: return "Français"
        case .spanish: return "Español"
        case .italian: return "Italiano"
        }
    }
    
    var englishName: String {
        switch self {
        case .english: return "Base"
        case .georgian: return "Georgian"
        case .russian: return "Russian"
        case .german: return "German"
        case .french: return "French"
        case .spanish: return "Spanish"
        case .italian: return "Italian"
        }
    }
}
