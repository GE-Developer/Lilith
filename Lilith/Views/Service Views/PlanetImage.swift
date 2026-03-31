//
//  PlanetImage.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct PlanetImage: View {
    private let planetName: String
    private let size: Double
    
    init(planetName: String, size: Double) {
        self.planetName = planetName
        self.size = size
    }
    
    var body: some View {
        planetImage
    }
    
    private enum Planet: String {
        case mercury, venus, earth, mars, jupiter,
             saturn, uranus, neptune, pluto, sun, moon
    }
}

// MARK: - Builder
extension PlanetImage {
    private var planetImage: some View {
        Group {
            if let planet = Planet(rawValue: planetName)?.rawValue.capitalized {
                Image(planet)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.sign.planet)
                    .frame(height: size)
            }
        }
    }
}
