//
//  ZodiacView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct ZodiacView: View {
    let zodiac: Zodiac
    let size: Double
    
    var body: some View {
        Image(zodiac.rawValue)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.sign.zodiac)
            .shadow(color: Color.sign.shadow, radius: 1)
            .frame(height: size)
    }
}
