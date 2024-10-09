//
//  SegmentedView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

struct SegmentedView: View {
    @State private var isButtonDisabled = false
    @Binding var activeTab: Arkan
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Arkan.allCases, id: \.self) { arkan in
                    segmentButtonPlaced(for: arkan)
                }
            }
        }
        .shadow(color: Color.main.viewShadow, radius: 3)
    }
    
    @ViewBuilder
    private func segmentButtonPlaced(for currentArkan: Arkan) -> some View {
        Button {
            didTapped(on: currentArkan)
        } label: {
            Text(currentArkan.shortPlural)
                .font(.callout)
                .fontDesign(.rounded)
                .foregroundStyle(
                    activeTab == currentArkan
                    ? Color.navigation.segmentTextPressed
                    : Color.navigation.segmentText
                )
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
        }
        .background { setupButton(currentArkan: currentArkan) }
        .buttonStyle(NoDimButtonStyle())
        .disabled(isButtonDisabled)
    }
    
    @ViewBuilder
    private func setupButton(currentArkan: Arkan) -> some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: activeTab == currentArkan
                    ? [Color.navigation.segmentBackgroundPressedOne,
                       Color.navigation.segmentBackgroundPressedTwo]
                    : [Color.navigation.segmentBackground],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
    
    private func didTapped(on arkan: Arkan) {
        guard activeTab != arkan else { return }
        withAnimation(.easeOut) {
            activeTab = arkan
        }
        isButtonDisabled = true
        // Устанавливаем таймер на 5 секунд, по истечении которого кнопка снова станет доступной
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            isButtonDisabled = false
        }
    }
}

struct NoDimButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
