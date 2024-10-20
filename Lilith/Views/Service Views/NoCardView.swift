//
//  NoCardView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct NoCardView: View {
    let text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Gradient.cellGradient)
            Text(text)
                .font(.title3)
                .fontDesign(.rounded)
                .fontWeight(.light)
                .foregroundStyle(Color.main.secondaryText)
        }
        .frame(height: 100)
    }
}
