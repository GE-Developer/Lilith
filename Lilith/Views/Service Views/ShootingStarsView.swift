//
//  ShootingStarsView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct ShootingStarsView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ShootingStar(
                startX: w * 0.8, startY: h * 0.05,
                endX: w * 0.15, endY: h * 0.45,
                angle: -30, length: 70,
                cycleDuration: 8, delay: 1
            )

            ShootingStar(
                startX: w * 0.5, startY: -10,
                endX: w * 0.85, endY: h * 0.35,
                angle: -55, length: 55,
                cycleDuration: 10, delay: 4
            )

            ShootingStar(
                startX: w * 0.15, startY: h * 0.08,
                endX: w * 0.7, endY: h * 0.3,
                angle: -22, length: 80,
                cycleDuration: 12, delay: 7
            )
        }
        .allowsHitTesting(false)
    }
}

private struct ShootingStar: View {
    let startX: CGFloat
    let startY: CGFloat
    let endX: CGFloat
    let endY: CGFloat
    let angle: Double
    let length: CGFloat
    let cycleDuration: Double
    let delay: Double

    @State private var progress: CGFloat = 0

    var body: some View {
        let flyRatio: CGFloat = 1.0 / cycleDuration
        let currentProgress = min(progress / flyRatio, 1.0)
        let visible = progress < flyRatio

        Capsule()
            .fill(Gradient.shootingStarGradient)
            .frame(width: length, height: 1.5)
            .rotationEffect(.degrees(angle))
            .position(
                x: startX + (endX - startX) * currentProgress,
                y: startY + (endY - startY) * currentProgress
            )
            .opacity(visible ? Double(sin(Double(currentProgress) * .pi) * 0.8) : 0)
            .onAppear {
                withAnimation(
                    .linear(duration: cycleDuration)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
                ) {
                    progress = 1.0
                }
            }
    }
}
