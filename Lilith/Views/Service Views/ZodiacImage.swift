//
//  ZodiacImage.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct ZodiacImage: View {
    private let zodiac: String
    private let size: Double
    
    init(zodiac: String, size: Double) {
        self.zodiac = zodiac
        self.size = size
    }
    
    var body: some View {
        zodiacImage
    }
    
    private enum Zodiac: String {
        case aries, taurus, gemini, cancer, leo, virgo, libra,
             scorpio, sagittarius, capricorn, aquarius, pisces
    }
}

// MARK: - Builder
extension ZodiacImage {
    private var zodiacImage: some View {
        Group {
            if let zodiac = Zodiac(rawValue: zodiac)?.rawValue.capitalized {
                Image(zodiac)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.sign.zodiac)
                    .frame(height: size)
            }
        }
    }
}
