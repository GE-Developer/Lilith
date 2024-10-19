//
//  PlanetView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct PlanetView: View {
    let planet: Planet
    let size: Double
    
    var body: some View {
        Image(planet.rawValue.capitalized)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.sign.planet)
            .frame(height: size)
    }
}
