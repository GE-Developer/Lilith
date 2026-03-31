//
//  View + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

extension View {
    
    // MARK: - Background Modifier
    func elementBackground() -> some View {
        return self.background {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.main.titleText)
        }
    }
}
