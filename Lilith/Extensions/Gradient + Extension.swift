//
//  Gradient + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

extension Gradient {
    static let cellGradient = LinearGradient(
        colors: [.navigation.cellOne, .navigation.cellTwo],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
    
    static let heartGradient = LinearGradient(
        colors: [.navigation.heartOne, .navigation.heartTwo],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let basicSubscriptionGradiaent = LinearGradient(
        colors: [.subscription.basicOne, .subscription.basicTwo],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
    
    static let premiumSubscriptionGradiaent = LinearGradient(
        colors: [.subscription.premiumOne, .subscription.premiumTwo],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let tileOrangeGradient: [Color] = [.home.tileOrangeOne, .home.tileOrangeTwo]
    static let tileAmberGradient: [Color] = [.home.tileAmberOne, .home.tileAmberTwo]
    static let shootingStarGradient = LinearGradient(
        colors: [Color.home.star.opacity(0.9), Color.home.star.opacity(0)],
        startPoint: .trailing,
        endPoint: .leading
    )

    static func textSegmentedGradient(isActive: Bool) -> LinearGradient {
        LinearGradient(
            colors: isActive
            ? [Color.navigation.segmentBackgroundPressedOne,
               Color.navigation.segmentBackgroundPressedTwo]
            : [Color.navigation.segmentBackground],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
