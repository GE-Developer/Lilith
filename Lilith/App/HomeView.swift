//
//  HomeView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct HomeView: View {
    @State private var showDecks = false
    @State private var showSpread = false
    @State private var showSettings = false

    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let moonSize = screenWidth * 1.15
            let headerHeight = moonSize + 60

            ZStack(alignment: .top) {
                heroHeader(screenWidth: screenWidth, moonSize: moonSize, headerHeight: headerHeight)
                    .frame(width: screenWidth, height: headerHeight)
                    .ignoresSafeArea(edges: .top)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Color.clear
                            .frame(height: headerHeight * 0.55)

                        contentSheet(screenHeight: geo.size.height, headerHeight: headerHeight)
                    }
                    .frame(width: screenWidth)
                }
                .ignoresSafeArea(edges: .top)
            }
            .frame(width: screenWidth)
            .overlay(alignment: .topTrailing) {
                settingsButton
            }
        }
        .background(Color.home.background.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showDecks) {
            NavigationLazyView(DecksView())
        }
        .navigationDestination(isPresented: $showSpread) {
            NavigationLazyView(SpreadView())
        }
        .navigationDestination(isPresented: $showSettings) {
            NavigationLazyView(SettingsView())
        }
    }
}

// MARK: - Settings Button
extension HomeView {
    private var settingsButton: some View {
        Button {
            HapticsManager.shared.impact(style: .light)
            showSettings = true
        } label: {
            Image.system.gearshape
                .font(.body)
                .foregroundStyle(Color.main.secondaryText)
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(color: Color.main.viewShadow, radius: 4, x: 0, y: 2)
        }
        .padding(.trailing, 20)
        .padding(.top, 8)
    }
}

// MARK: - Hero Header
extension HomeView {
    private func heroHeader(screenWidth: CGFloat, moonSize: CGFloat, headerHeight: CGFloat) -> some View {
        ZStack {
            Color.home.background
            StarsView()
            ShootingStarsView()

            VStack(spacing: 0) {
                Spacer(minLength: 50)

                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.navigation.segmentBackgroundPressedOne.opacity(0.2),
                                    Color.navigation.segmentBackgroundPressedTwo.opacity(0.12),
                                    .clear
                                ],
                                center: .center,
                                startRadius: moonSize * 0.15,
                                endRadius: moonSize * 0.55
                            )
                        )
                        .frame(width: moonSize * 1.1, height: moonSize * 1.1)

                    Moon3DView()
                        .frame(width: moonSize, height: moonSize)

                    MoonMagicParticlesView(moonRadius: moonSize * 0.42)
                        .frame(width: moonSize * 1.1, height: moonSize * 1.1)
                }

                Spacer(minLength: 0)
            }
        }
    }
}

// MARK: - Content Sheet
extension HomeView {
    private func contentSheet(screenHeight: CGFloat, headerHeight: CGFloat) -> some View {
        let sheetMinHeight = screenHeight - headerHeight * 0.55 + 24

        return VStack(spacing: 20) {
            Capsule()
                .fill(Color.main.secondaryText.opacity(0.3))
                .frame(width: 36, height: 4)
                .padding(.top, 10)

            greetingSection

            HomeServiceTilesView(
                onDecks: { showDecks = true },
                onSpread: { showSpread = true }
            )

            Spacer(minLength: 40)
        }
        .padding(.horizontal, 20)
        .frame(minHeight: sheetMinHeight)
        .background(alignment: .top) {
            Color.main.background
                .frame(height: sheetMinHeight + 1000)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 24,
                        topTrailingRadius: 24
                    )
                )
                .shadow(color: .black.opacity(0.3), radius: 12, y: -4)
        }
        .offset(y: -24)
    }

    private var greetingSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(L10n("UI.Home.welcome"))
                .font(.title2)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundStyle(Color.main.titleText)

            Text(L10n("UI.Home.subtitle"))
                .font(.subheadline)
                .fontWeight(.light)
                .fontDesign(.rounded)
                .foregroundStyle(Color.main.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 4)
    }
}
