//
//  Element.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 11.10.24.
//

import Foundation

enum Element: Hashable, CaseIterable {
    case fire, water, earth, air
    
    var name: String {
        switch self {
        case .fire: return L10n.Element.fire
        case .water: return L10n.Element.water
        case .earth: return L10n.Element.earth
        case .air: return L10n.Element.air
        }
    }
}
