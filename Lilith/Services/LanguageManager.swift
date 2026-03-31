//
//  LanguageManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@Observable
final class LanguageManager: @unchecked Sendable {
    
    static let shared = LanguageManager()

    var currentLanguageID: String {
        didSet {
            defaults.set([currentLanguageID], forKey: key)
            defaults.synchronize()
            Task { @MainActor in
                JSONDataService.shared.reloadForLanguage(currentLanguageID)
            }
        }
    }

    var bundle: Bundle? {
        guard let path = Bundle.main.path(forResource: currentLanguageID, ofType: "lproj") else {
            return .main
        }
        return Bundle(path: path)
    }

    private let defaults = UserDefaults.standard
    private let key = AppStorageKey.language.key
    
    private init() {
        let baseAppLanguage = Bundle.main.developmentLocalization ?? AppLanguage.english.id
        let baseUserLanguage = Bundle.main.preferredLocalizations.first
        
        currentLanguageID = baseUserLanguage ?? baseAppLanguage
    }
}
