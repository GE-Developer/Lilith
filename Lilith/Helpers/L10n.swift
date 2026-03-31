//
//  L10n.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

public func L10n(_ key: String.LocalizationValue) -> String {
    String(localized: key, table: "AppLocalization", bundle: LanguageManager.shared.bundle)
}

public func L10n(_ key: String, _ args: CVarArg...) -> String {
    let format = LanguageManager.shared.bundle?
        .localizedString(forKey: key, value: nil, table: "AppLocalization") ?? key
    return String(format: format, arguments: args)
}
