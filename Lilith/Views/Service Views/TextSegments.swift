//
//  TextSegments.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct TextSegments: View {
    @Binding var activeTab: String?
    @State private var isButtonDisabled = false
    
    private let tabs: [String]
    private let haptics = HapticsManager.shared
    
    init(activeTab: Binding<String?>, tabs: [String]) {
        self._activeTab = activeTab
        self.tabs = tabs
    }
    
    var body: some View {
        textSegments
    }
}

// MARK: - Logic
extension TextSegments {
    private func buttonPressed(on newTab: String, scrollProxy: ScrollViewProxy) {
        guard activeTab != newTab else { return }
        isButtonDisabled = true
        
        withAnimation(.easeInOut) {
            activeTab = newTab
            scrollProxy.scrollTo(newTab, anchor: .center)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            isButtonDisabled = false
        }
        
        haptics.selectionChanged()
    }
}

// MARK: - Builder
extension TextSegments {
    private var textSegments: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(tabs, id: \.self) { tab in
                        segmentButton(tab: tab, scrollProxy: scrollProxy)
                    }
                }
            }
            .shadow(color: Color.main.viewShadow, radius: 3)
        }
    }
    
    private func segmentButton(tab: String, scrollProxy: ScrollViewProxy) -> some View {
        Button {
            buttonPressed(on: tab, scrollProxy: scrollProxy)
        } label: {
            Text(tab)
                .font(.callout)
                .fontDesign(.rounded)
                .foregroundStyle(
                    activeTab == tab
                    ? Color.navigation.segmentTextPressed
                    : Color.navigation.segmentText
                )
                .padding(.vertical, 8)
                .padding(.horizontal, 25)
        }
        .background {
            Capsule()
                .fill(Gradient.textSegmentedGradient(isActive: activeTab == tab))
        }
        .buttonStyle(NoDimButtonStyle())
        .disabled(isButtonDisabled)
        .id(tab)
    }
}

// MARK: - Configurations
fileprivate struct NoDimButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
