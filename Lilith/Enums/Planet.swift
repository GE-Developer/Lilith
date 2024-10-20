//
//  Planet.swift
//  Lilith
//
//  Created by GE-Developer
//

enum Planet: String {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
    case sun
    case moon
    
    var name: String {
        switch self {
        case .mercury: return L10n.Planet.mercury
        case .venus: return L10n.Planet.venus
        case .earth: return L10n.Planet.earth
        case .mars: return L10n.Planet.mars
        case .jupiter: return L10n.Planet.jupiter
        case .saturn: return L10n.Planet.saturn
        case .uranus: return L10n.Planet.uranus
        case .neptune: return L10n.Planet.neptune
        case .pluto: return L10n.Planet.pluto
        case .sun: return L10n.Planet.sun
        case .moon: return L10n.Planet.moon
        }
    }
}
