//
//  SpreadMessageView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SpreadMessageView: View {
    private let message: SpreadMessage

    init(message: SpreadMessage) {
        self.message = message
    }

    var body: some View {
        switch message.type {
        case .question(let text):
            questionBubble(text)
        case .aiMessage(let text):
            aiBubble(text)
        case .cards(let cards, let c1, let c2, let c3, let summary):
            SpreadFanView(cards: cards, interpretations: [c1, c2, c3], summary: summary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
    }
}

// MARK: - Bubbles
extension SpreadMessageView {

    // Пользователь — правый пузырь
    private func questionBubble(_ text: String) -> some View {
        HStack {
            Spacer(minLength: 60)
            Text(text)
                .font(.body)
                .foregroundStyle(Color.main.titleText)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    LinearGradient(
                        colors: [Color.navigation.segmentBackgroundPressedOne,
                                 Color.navigation.segmentBackgroundPressedTwo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(CustomRoundedCorners(radius: 18, corners: [.topLeft, .topRight, .bottomLeft]))
                .shadow(color: Color.main.viewShadow, radius: 3, x: 0, y: 2)
        }
        .padding(.horizontal, 16)
    }

    // Таролог — левый пузырь
    private func aiBubble(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.navigation.segmentBackgroundPressedTwo.opacity(0.3),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 5,
                            endRadius: 20
                        )
                    )
                    .frame(width: 36, height: 36)

                Image.system.sparkles
                    .font(.caption)
                    .foregroundStyle(Color.sign.zodiac)
                    .frame(width: 28, height: 28)
                    .background(
                        LinearGradient(
                            colors: [Color.navigation.cellOne, Color.navigation.cellTwo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.navigation.segmentBackgroundPressedTwo.opacity(0.4), radius: 4)
            }

            Text(text)
                .font(.body)
                .foregroundStyle(Color.main.text)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    LinearGradient(
                        colors: [Color.navigation.cellOne, Color.navigation.cellTwo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(CustomRoundedCorners(radius: 18, corners: [.topLeft, .topRight, .bottomRight]))
                .shadow(color: Color.main.viewShadow, radius: 3, x: 0, y: 2)

            Spacer(minLength: 60)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Fan View
struct SpreadFanView: View {
    let cards: [Card]
    let interpretations: [String]
    let summary: String

    @State private var appeared = false

    private let cardWidth: CGFloat = 95
    private let rotations: [Double] = [-22, 0, 22]
    private let offsetsX: [CGFloat] = [-68, 0, 68]
    private let offsetsY: [CGFloat] = [18, 0, 18]
    private let zIndexes: [Double]  = [0, 2, 1]
    private let romanNumerals       = ["I", "II", "III"]

    var body: some View {
        VStack(spacing: 20) {
            fanCards
            cardDetails
            if !summary.isEmpty {
                summaryBlock
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.65, dampingFraction: 0.72)) {
                appeared = true
            }
        }
    }

    // MARK: Fan
    private var fanCards: some View {
        ZStack(alignment: .bottom) {
            // Mystic glow behind cards
            Ellipse()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.navigation.segmentBackgroundPressedTwo.opacity(appeared ? 0.2 : 0),
                            Color.navigation.segmentBackgroundPressedOne.opacity(appeared ? 0.08 : 0),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 120
                    )
                )
                .frame(width: 250, height: 180)
                .blur(radius: 20)
                .offset(y: -20)
                .animation(.easeOut(duration: 1.0).delay(0.3), value: appeared)

            ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                fanCard(card: card, index: index)
            }
        }
        .frame(height: cardWidth / 2 * 3 + 50)
    }

    private func fanCard(card: Card, index: Int) -> some View {
        CustomAsyncImage(imageUrl: card.imageUrl ?? "", 2/3, .fill)
            .frame(width: cardWidth)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.main.viewShadow, radius: 8, x: 0, y: 6)
            .rotationEffect(.degrees(appeared ? rotations[index] : 0), anchor: .bottom)
            .offset(x: appeared ? offsetsX[index] : 0, y: appeared ? offsetsY[index] : 0)
            .scaleEffect(appeared ? 1 : 0.4)
            .opacity(appeared ? 1 : 0)
            .zIndex(zIndexes[index])
            .animation(
                .spring(response: 0.65, dampingFraction: 0.72).delay(Double(index) * 0.12),
                value: appeared
            )
    }

    // MARK: Card details — название + интерпретация
    private var cardDetails: some View {
        VStack(spacing: 16) {
            ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                cardDetailRow(card: card, index: index)
            }
        }
    }

    // MARK: Summary
    private var summaryBlock: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                MysticDividerLine()
                Image.system.sparkles
                    .font(.caption)
                    .foregroundStyle(Color.sign.zodiac)
                MysticDividerLine()
            }

            Text(L10n("UI.Spread.summary"))
                .font(.caption2)
                .fontWeight(.light)
                .foregroundStyle(Color.main.secondaryText)
                .tracking(3)
                .textCase(.uppercase)

            Text(summary)
                .font(.callout)
                .foregroundStyle(Color.main.text)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 4)
        }
        .padding(.top, 4)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.6).delay(0.9), value: appeared)
    }

    private func cardDetailRow(card: Card, index: Int) -> some View {
        VStack(spacing: 6) {
            // Позиция
            Text(romanNumerals[index])
                .font(.caption2)
                .fontWeight(.light)
                .foregroundStyle(Color.main.secondaryText)
                .tracking(3)

            // Название карты
            Text(card.title ?? "")
                .font(.callout)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundStyle(Color.main.titleText)
                .multilineTextAlignment(.center)

            // Разделитель
            HStack {
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundStyle(Color.main.secondaryText.opacity(0.3))
            }
            .padding(.horizontal, 24)

            // Интерпретация от GPT
            if index < interpretations.count {
                Text(interpretations[index])
                    .font(.footnote)
                    .foregroundStyle(Color.main.text)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity)
        .opacity(appeared ? 1 : 0)
        .animation(
            .easeOut(duration: 0.5).delay(Double(index) * 0.15 + 0.6),
            value: appeared
        )
    }
}

// MARK: - Mystic Divider
private struct MysticDividerLine: View {
    @State private var shimmer = false

    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.sign.zodiac.opacity(0.1),
                        Color.sign.zodiac.opacity(0.5),
                        Color.navigation.segmentBackgroundPressedTwo.opacity(0.5),
                        Color.sign.zodiac.opacity(0.1)
                    ],
                    startPoint: shimmer ? .leading : .trailing,
                    endPoint: shimmer ? .trailing : .leading
                )
            )
            .frame(height: 0.5)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    shimmer = true
                }
            }
    }
}

// MARK: - Shape
private struct CustomRoundedCorners: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
