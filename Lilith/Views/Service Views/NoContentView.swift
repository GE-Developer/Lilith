//
//  NoContentView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct NoContentView: View {
    private let text: String
    private let height: CGFloat
    
    init(text: String, _ height: CGFloat) {
        self.text = text
        self.height = height
    }
    
    var body: some View {
        noContent
    }
}

// MARK: - Builder
extension NoContentView {
    private var noContent: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Gradient.cellGradient)
            Text(text)
                .font(.title3)
                .fontDesign(.rounded)
                .fontWeight(.light)
                .foregroundStyle(Color.main.secondaryText)
        }
        .frame(height: height)
    }
}
