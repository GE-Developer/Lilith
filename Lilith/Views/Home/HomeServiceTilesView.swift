//
//  HomeServiceTilesView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct HomeServiceTilesView: View {
    var onDecks: () -> Void
    var onSpread: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 14) {
                serviceTile(
                    title: L10n("UI.Home.Tile.decks"),
                    tag: L10n("UI.Home.Tile.tarot"),
                    icon: .system.decksCard,
                    gradient: [Color.navigation.heartOne,
                               Color.navigation.heartTwo]
                ) {
                    HapticsManager.shared.impact(style: .medium)
                    onDecks()
                }

                serviceTile(
                    title: L10n("UI.Home.Tile.numerology"),
                    tag: L10n("UI.Home.Tile.numbers"),
                    icon: .system.number,
                    gradient: [Color.navigation.segmentBackgroundPressedOne,
                               Color.navigation.segmentBackgroundPressedTwo]
                ) {
                    HapticsManager.shared.impact(style: .medium)
                }
            }

            HStack(spacing: 14) {
                serviceTile(
                    title: L10n("UI.Home.Tile.tests"),
                    tag: L10n("UI.Home.Tile.knowYourself"),
                    icon: .system.checklist,
                    gradient: Gradient.tileOrangeGradient
                ) {
                    HapticsManager.shared.impact(style: .medium)
                }

                serviceTile(
                    title: L10n("UI.Home.Tile.astrology"),
                    tag: L10n("UI.Home.Tile.stars"),
                    icon: .system.starCircle,
                    gradient: Gradient.tileAmberGradient
                ) {
                    HapticsManager.shared.impact(style: .medium)
                }
            }

            serviceBanner(
                title: L10n("UI.Home.Tile.spreads"),
                subtitle: L10n("UI.Home.Tile.askCards"),
                icon: .system.sparkles,
                gradient: [Color(red: 0.95, green: 0.55, blue: 0.15),
                           Color(red: 0.75, green: 0.30, blue: 0.05)]
            ) {
                HapticsManager.shared.impact(style: .medium)
                onSpread()
            }

            serviceBanner(
                title: L10n("UI.Home.Tile.angelMessage"),
                subtitle: L10n("UI.Home.Tile.everyDay"),
                icon: .system.envelopeOpen,
                gradient: [Color(red: 0.90, green: 0.45, blue: 0.10),
                           Color(red: 0.65, green: 0.22, blue: 0.0)]
            ) {
                HapticsManager.shared.impact(style: .medium)
            }
        }
    }

    private func serviceTile(
        title: String,
        tag: String,
        icon: Image,
        gradient: [Color],
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            ZStack(alignment: .topLeading) {
                LinearGradient(
                    colors: gradient.map { $0.opacity(0.15) },
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Circle()
                    .fill(
                        LinearGradient(
                            colors: gradient.map { $0.opacity(0.3) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                    .blur(radius: 30)
                    .offset(x: 40, y: 10)

                VStack(alignment: .leading, spacing: 0) {
                    Text(tag)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(gradient.first ?? .home.star)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.main.background.opacity(0.8))
                        )

                    Spacer()

                    icon
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .padding(.bottom, 6)

                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .foregroundStyle(Color.main.titleText)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(16)
            }
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.main.background.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: Color.main.viewShadow, radius: 5, x: 0, y: 3)
        }
    }

    private func serviceBanner(
        title: String,
        subtitle: String,
        icon: Image,
        gradient: [Color],
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            ZStack(alignment: .leading) {
                LinearGradient(
                    colors: gradient.map { $0.opacity(0.15) },
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Circle()
                    .fill(
                        LinearGradient(
                            colors: gradient.map { $0.opacity(0.3) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .blur(radius: 40)
                    .offset(x: 200, y: -10)

                HStack(spacing: 14) {
                    icon
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 44, height: 44)
                        .background(Color.main.background.opacity(0.8))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.main.titleText)

                        Text(subtitle)
                            .font(.caption)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.main.secondaryText)
                    }

                    Spacer()

                    Image.system.chevron
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(gradient.first ?? .home.star)
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 72)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.main.background.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: Color.main.viewShadow, radius: 5, x: 0, y: 3)
        }
    }
}
