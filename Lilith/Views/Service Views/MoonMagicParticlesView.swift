//
//  MoonMagicParticlesView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct MoonMagicParticlesView: View {
    let moonRadius: CGFloat
    let particleCount = 8

    var body: some View {
        ZStack {
            ForEach(0..<particleCount, id: \.self) { i in
                MoonMagicParticle(index: i, moonRadius: moonRadius)
            }
        }
        .allowsHitTesting(false)
    }
}

private struct MoonMagicParticle: View {
    let index: Int
    let moonRadius: CGFloat

    @State private var driftX: CGFloat = 0
    @State private var driftY: CGFloat = 0
    @State private var opacity: Double = 0

    private var size: CGFloat { CGFloat.random(in: 2...4) }
    private var angle: Double { Double(index) / 8.0 * .pi * 2 }
    private var radius: CGFloat { moonRadius * CGFloat.random(in: 0.85...1.1) }
    private var duration: Double { Double.random(in: 3...6) }

    private var color: Color {
        switch index % 3 {
        case 0: Color.navigation.segmentBackgroundPressedOne.opacity(0.6)
        case 1: Color.navigation.segmentBackgroundPressedTwo.opacity(0.5)
        default: Color.sign.zodiac.opacity(0.4)
        }
    }

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .blur(radius: 1)
            .offset(
                x: cos(angle) * radius + driftX,
                y: sin(angle) * radius + driftY
            )
            .opacity(opacity)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true)
                    .delay(Double(index) * 0.3)
                ) {
                    driftX = CGFloat.random(in: -20...20)
                    driftY = CGFloat.random(in: -20...20)
                    opacity = 0.8
                }
            }
    }
}
