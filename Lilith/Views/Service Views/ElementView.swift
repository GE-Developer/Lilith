//
//  ElementView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct ElementView: View {
    let element: Element
    let stroke: Double
    
    var body: some View {
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
                
                if element == .earth || element == .air {
                    path.move(to: CGPoint(x: w / 4.58, y: h / 2 * 1.15))
                    path.addLine(to: CGPoint(x: w - w / 4.58, y: h / 2 * 1.15))
                    path.closeSubpath()
                }
            }
            .stroke(lineWidth: stroke)
            .offset(y: -BY/2)
            .foregroundStyle(setColor())
            .shadow(color: Color.sign.shadow, radius: 5)
            .rotationEffect(setRotationDegrees())
        }
    }
    
    private func setRotationDegrees() -> Angle {
        switch element {
        case .water, .earth: .degrees(180)
        default: .degrees(0)
        }
    }
    
    private func setColor() -> Color {
        switch element {
        case .fire: Color.sign.fire
        case .water: Color.sign.water
        case .earth: Color.sign.earth
        case .air: Color.sign.air
        }
    }
}
