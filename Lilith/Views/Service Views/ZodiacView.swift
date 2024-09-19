//
//  ZodiacView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 05.09.24.
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
            .foregroundStyle(Color.main.zodiacForeground)
            .shadow(color: Color.main.zodiacShadow, radius: 1)
            .frame(height: size)
    }
}
