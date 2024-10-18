//
//  SegmentedView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SegmentedView: View {
    @ObservedObject var vm: CardsViewModel
    @State private var isButtonDisabled = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Arcana.allCases, id: \.self) { arkan in
                    segmentButtonPlaced(for: arkan)
                }
            }
        }
        .shadow(color: Color.main.viewShadow, radius: 3)
    }
    
    private func didTapped(on arkan: Arcana) {
        guard vm.activeTab != arkan else { return }
        
        withAnimation(.easeOut) {
            vm.activeTab = arkan
        }
        isButtonDisabled = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            isButtonDisabled = false
        }
    }
}

extension SegmentedView {
    @ViewBuilder
    private func segmentButtonPlaced(for currentArkan: Arcana) -> some View {
        Button {
            didTapped(on: currentArkan)
        } label: {
            Text(currentArkan.shortPlural + " " + vm.countAllCards(for: currentArkan))
                .font(.callout)
                .fontDesign(.rounded)
                .foregroundStyle(
                    vm.activeTab == currentArkan
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
    private func setupButton(currentArkan: Arcana) -> some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: vm.activeTab == currentArkan
                    ? [Color.navigation.segmentBackgroundPressedOne,
                       Color.navigation.segmentBackgroundPressedTwo]
                    : [Color.navigation.segmentBackground],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

fileprivate struct NoDimButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
