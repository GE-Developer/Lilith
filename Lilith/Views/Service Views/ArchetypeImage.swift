//
//  ArchetypeImage.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct ArchetypeImage: View {
    
    private let size: Double
    
    init(size: Double) {
        self.size = size
    }
    
    var body: some View {
        archetypeImage
    }
}

// MARK: - Builder
extension ArchetypeImage {
    private var archetypeImage: some View {
        Image.custom.archetype
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.sign.archtype)
            .frame(height: size)
    }
}
