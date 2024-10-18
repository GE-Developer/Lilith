//
//  Element.swift
//  Lilith
//
//  Created by GE-Developer
//

enum Element {
    case fire
    case water
    case earth
    case air
    
    var name: String {
        switch self {
        case .fire: return L10n.Element.fire
        case .water: return L10n.Element.water
        case .earth: return L10n.Element.earth
        case .air: return L10n.Element.air
        }
    }
}
