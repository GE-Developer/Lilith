//
//  ElementImage.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct ElementImage: View {
    private let element: String
    private let stroke: Double
    
    init(element: String, stroke: Double) {
        self.element = element
        self.stroke = stroke
    }
    
    var body: some View {
        elementImage
    }
    
    private enum Element: String {
        case fire, water, earth, air
    }
}

// MARK: - Logic
extension ElementImage {
    private func setRotationDegrees() -> Angle {
        switch element {
        case Element.water.rawValue: .degrees(180)
        case Element.earth.rawValue: .degrees(180)
        default: .degrees(0)
        }
    }
    
    private func setColor() -> Color {
        switch element {
        case Element.fire.rawValue: return Color.sign.fire
        case Element.water.rawValue: return Color.sign.water
        case Element.earth.rawValue: return Color.sign.earth
        case Element.air.rawValue: return Color.sign.air
        default: return Color.clear
        }
    }
}


// MARK: - Builder
extension ElementImage {
    private var elementImage: some View {
        GeometryReader { geometry in
            let h = geometry.size.height
            let w = geometry.size.width
            
            let BX = w / 2
            let BY =  h - (sqrt(3) / 2) * h
            
            Path { path in
                path.move(to: CGPoint(x: w * 0.02, y: h * 0.93))
                path.addLine(to: CGPoint(x: BX * 0.9, y: BY * 1.2))
                path.addQuadCurve(to: CGPoint(x: BX * 1.1, y: BY * 1.2), control: CGPoint(x: BX, y: BY * 0.6))
                path.addLine(to: CGPoint(x: w * 0.98, y: h * 0.93))
                path.addQuadCurve(to: CGPoint(x: w * 0.91, y: h), control: CGPoint(x: w, y: h))
                path.addLine(to: CGPoint(x: w * 0.09, y: h))
                path.addQuadCurve(to: CGPoint(x: w * 0.02, y: h * 0.93), control: CGPoint(x: 0, y: h))
                path.closeSubpath()
                
                if element == Element.earth.rawValue || element == Element.air.rawValue {
                    path.move(to: CGPoint(x: w / 4.58, y: h / 2 * 1.15))
                    path.addLine(to: CGPoint(x: w - w / 4.58, y: h / 2 * 1.15))
                    path.closeSubpath()
                }
            }
            .stroke(lineWidth: stroke)
            .offset(y: -BY/2)
            .foregroundStyle(setColor())
            .rotationEffect(setRotationDegrees())
        }
    }
}
