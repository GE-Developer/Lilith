//
//  SegmentedView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Custom Segmented Control
struct SegmentedView: View {
    
    /// View Properties
    @Binding var activeTab: Arkan
    @Namespace private var animation
    
    /// Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Arkan.allCases, id: \.self) { arkan in
                    Button(action: { didTapped(on: arkan) }) {
                        Text(arkan.shortPlural)
                            .font(.callout)
                            .foregroundStyle(Color.main.secondaryText)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            .background { setupButton(currentArkan: arkan) }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }

        }
        .shadow(color: Color.main.zodiacShadow, radius: 4)
    }
    
    private func didTapped(on arkan: Arkan) {
        withAnimation(.snappy) {
            activeTab = arkan
        }
    }
    
    @ViewBuilder
    private func setupButton(currentArkan: Arkan) -> some View {
        if activeTab == currentArkan {
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [Color.main.cell, Color.main.cell.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
        } else {
            Capsule()
                .fill(Color.main.button)
        }
    }
}
