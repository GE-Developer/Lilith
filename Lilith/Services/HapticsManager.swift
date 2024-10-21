//
//  HapticsManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import UIKit

@MainActor
final class HapticsManager {
    static let shared = HapticsManager()
    
    private init() {}
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium, vol: CGFloat = 1, delay: Double = 0) {
        let impactGenerator = UIImpactFeedbackGenerator(style: style)
        impactGenerator.prepare()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            impactGenerator.impactOccurred(intensity: vol)
        }
    }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType, delay: Double = 0) {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            notificationGenerator.notificationOccurred(type)
        }
    }
    
    func selectionChanged(delay: Double = 0) {
        let selectionGenerator = UISelectionFeedbackGenerator()
        selectionGenerator.prepare()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            selectionGenerator.selectionChanged()
        }
    }
}
