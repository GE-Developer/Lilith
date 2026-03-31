//
//  StarsView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct StarsView: View {
    let starCount = 50

    var body: some View {
        GeometryReader { geo in
            ForEach(0..<starCount, id: \.self) { i in
                StarView(
                    size: CGFloat.random(in: 1...4),
                    x: CGFloat.random(in: 0...geo.size.width),
                    y: CGFloat.random(in: 0...geo.size.height * 0.85),
                    duration: Double.random(in: 1.0...3.0),
                    delay: Double.random(in: 0...2.0)
                )
            }
        }
        .allowsHitTesting(false)
    }
}

private struct StarView: View {
    let size: CGFloat
    let x: CGFloat
    let y: CGFloat
    let duration: Double
    let delay: Double

    @State private var opacity: Double = 0.05
    @State private var driftX: CGFloat = 0
    @State private var driftY: CGFloat = 0
    @State private var scale: CGFloat = 0.7

    var body: some View {
        Circle()
            .fill(Color.home.star)
            .frame(width: size, height: size)
            .opacity(opacity)
            .scaleEffect(scale)
            .position(x: x + driftX, y: y + driftY)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true)
                    .delay(delay)
                ) {
                    opacity = Double.random(in: 0.6...1.0)
                    scale = CGFloat.random(in: 1.0...1.4)
                }
                withAnimation(
                    .easeInOut(duration: duration * 2.5)
                    .repeatForever(autoreverses: true)
                    .delay(delay + 0.5)
                ) {
                    driftX = CGFloat.random(in: -15...15)
                    driftY = CGFloat.random(in: -12...12)
                }
            }
    }
}
