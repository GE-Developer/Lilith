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
}
