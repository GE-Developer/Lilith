//
//  LanguageViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@Observable
@MainActor
final class LanguageViewModel {

    var tappedLanguage: AppLanguage?

    var title: String { L10n("UI.ChangeLanguage.title") }
    var alertTitle: String { L10n("UI.ChangeLanguage.Alert.title") }
    var alertMessage: String { L10n("UI.ChangeLanguage.Alert.message") }
    var alertActionTitle: String { L10n("UI.ChangeLanguage.Alert.action") }
    var alertCancelTitle: String { L10n("UI.cancel") }

    private let languageManager = LanguageManager.shared

    init() {
        tappedLanguage = AppLanguage(rawValue: languageManager.currentLanguageID)
    }

    func isWithCheckmark(_ language: AppLanguage) -> Bool {
        language.id == languageManager.currentLanguageID
    }

    func setNewLanguage() {
        languageManager.currentLanguageID = tappedLanguage?.id ?? AppLanguage.english.id
    }
}
