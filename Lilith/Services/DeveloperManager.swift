//
//  DeveloperManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

@MainActor
@Observable
final class DeveloperManager {
    
    var isPremium: Bool {
        didSet { defaults.set(isPremium, forKey: devPremiumKey) }
    }
    
    var isEarlyAccess: Bool {
        didSet { defaults.set(isEarlyAccess, forKey: earlyAccessKey) }
    }
    
    var isBetaFeaturesAccess: Bool {
        didSet { defaults.set(isBetaFeaturesAccess, forKey: betaFeaturesKey) }
    }
    
    static let shared = DeveloperManager()
    
    private let defaults = UserDefaults.standard
    private let devPremiumKey = AppStorageKey.devPremium.key
    private let earlyAccessKey = AppStorageKey.earlyAccess.key
    private let betaFeaturesKey = AppStorageKey.betaFeatures.key
    
    private init() {
        isPremium = defaults.bool(forKey: devPremiumKey)
        isEarlyAccess = defaults.bool(forKey: earlyAccessKey)
        isBetaFeaturesAccess = defaults.bool(forKey: betaFeaturesKey)
    }
}
