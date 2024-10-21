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
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Arcana.allCases, id: \.self) { arkan in
                        segmentButtonPlaced(for: arkan, scrollProxy: scrollProxy)
                    }
                }
            }
            .shadow(color: Color.main.viewShadow, radius: 3)
        }
    }
    
    private func didTapped(on arkan: Arcana, scrollProxy: ScrollViewProxy) {
        guard vm.activeTab != arkan else { return }
        isButtonDisabled = true

        withAnimation(.easeInOut) {
            vm.activeTab = arkan
            scrollProxy.scrollTo(arkan, anchor: .center)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            isButtonDisabled = false
        }
    }
}

extension SegmentedView {
    @ViewBuilder
    private func segmentButtonPlaced(for currentArkan: Arcana, scrollProxy: ScrollViewProxy) -> some View {
        Button {
            didTapped(on: currentArkan, scrollProxy: scrollProxy)
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
        .id(currentArkan)
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
