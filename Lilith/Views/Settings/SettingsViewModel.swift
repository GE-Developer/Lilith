//
//  SettingsViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@MainActor
@Observable
final class SettingsViewModel {
    
    var isThemeLight: Bool {
        didSet { themeManager.isThemeLight = isThemeLight }
    }
    
    var language: String {
        AppLanguage(rawValue: languageManager.currentLanguageID)?.localizedName ?? ""
    }
    
    var isHapticsOff: Bool {
        didSet { hapticsManager.isHapticsOff = isHapticsOff }
    }
    
    var isSoundOff: Bool {
        didSet { soundManager.isSoundOff = isSoundOff }
    }
    
    var access: Bool {
        subscriptionManager.isPremium
    }
    
    let appVersion: String
    
    var title: String { L10n("UI.Settings.title") }

    var generalSettingsTitle: String { L10n("UI.Settings.generalSettings") }
    var darkModeTitle: String { L10n("UI.Settings.darkMode") }
    var languageTitle: String { L10n("UI.Settings.language") }
    var vibrationTitle: String { L10n("UI.Settings.vibration") }
    var soundTitle: String { L10n("UI.Settings.sound") }
    var notificationsTitle: String { L10n("UI.Settings.notifications") }

    var subscriptionAndAccessTitle: String { L10n("UI.Settings.subscriptionAndAccess") }
    let premiumBannerTitle = "Premium"
    let basicBannerTitle = "Basic"
    var subscriptionTitle: String { L10n("UI.Settings.subscription") }
    var restorePurchasesTitle: String { L10n("UI.Settings.restorePurchases") }
    var reviewTitle: String { L10n("UI.Settings.review") }

    var memoryTitle: String { L10n("UI.Settings.memory") }
    var clearCacheTitle: String { L10n("UI.Settings.clearCache") }
    var clearHistoryTitle: String { L10n("UI.Settings.clearHistory") }
    var resetAllTitle: String { L10n("UI.Settings.resetAll") }

    var customizationTitle: String { L10n("UI.Settings.customization") }
    var appIconTitle: String { L10n("UI.Settings.appIcon") }
    var backgroundMusicTitle: String { L10n("UI.Settings.backgroundMusic") }

    var aboutAppTitle: String { L10n("UI.Settings.aboutApp") }
    var termsOfUseTitle: String { L10n("UI.Settings.termsOfUse") }
    var privacyPolicyTitle: String { L10n("UI.Settings.privacyPolicy") }
    var developersTitle: String { L10n("UI.Settings.developers") }
    
    private let themeManager = ThemeManager.shared
    private let languageManager = LanguageManager.shared
    private let hapticsManager = HapticsManager.shared
    private let soundManager = SoundManager.shared
    private let subscriptionManager = DeveloperManager.shared
    
    init() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
        
        isThemeLight = themeManager.isThemeLight
        isHapticsOff = hapticsManager.isHapticsOff
        isSoundOff = soundManager.isSoundOff
        appVersion = "\(version) (\(build))"
    }
    
    func clearCache() {
        for lang in AppLanguage.allCases {
            try? CacheManager.shared.deleteCache(for: lang.id)
        }
        JSONDataService.shared.clearData()
        Task {
            await JSONDataService.shared.load()
        }
    }

    // TODO: - Implement resetData
    func resetData() {
    }
    
    func changeAccess() {
        subscriptionManager.isPremium.toggle()
    }
}
