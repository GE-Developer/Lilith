//
//  Extension + Gradient.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 04.10.24.
//

import SwiftUI

extension Gradient {
    static let cellGradient = LinearGradient(
        colors: [Color.navigation.cellOne, Color.navigation.cellTwo],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
    
    static let heartGradient = LinearGradient(
        colors: [Color.navigation.heartOne, Color.navigation.heartTwo],
        startPoint: .leading,
        endPoint: .trailing
    )
    
}
