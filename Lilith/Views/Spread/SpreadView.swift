//
//  SpreadView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SpreadView: View {
    @State private var vm = SpreadViewModel()
    @FocusState private var isInputFocused: Bool

    private var bottomPadding: CGFloat {
        let window = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    }

    var body: some View {
        CustomScrollView { isLarge in
            CustomNavigationBar(title: vm.screenTitle, isLarge: isLarge)
            Spacer()
        } scrollView: {
            ZStack {
                MysticParticlesView()
                chatContent
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            inputBar
        }
        .task {
            vm.loadCards()
        }
    }
}

// MARK: - Chat Content
extension SpreadView {
    private var chatContent: some View {
        ScrollViewReader { proxy in
            LazyVStack(spacing: 12) {
                if vm.messages.isEmpty && vm.loadingState == .loading {
                    loadingHint
                }

                ForEach(vm.messages) { message in
                    SpreadMessageView(message: message)
                        .id(message.id)
                }

                if vm.isThinking {
                    thinkingIndicator
                        .id("thinking")
                }

                Color.clear
                    .frame(height: 4)
                    .id("bottom")
            }
            .padding(.vertical, 12)
            .onChange(of: vm.messages.count) { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
            .onChange(of: vm.isThinking) { _, thinking in
                if thinking {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            proxy.scrollTo("thinking", anchor: .bottom)
                        }
                    }
                }
            }
        }
    }

    private var loadingHint: some View {
        VStack(spacing: 16) {
            MysticOrbView()
                .frame(width: 60, height: 60)

            Text(L10n("UI.Spread.shuffling"))
                .font(.caption)
                .fontDesign(.rounded)
                .foregroundStyle(Color.main.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }

    private var thinkingIndicator: some View {
        HStack(alignment: .top) {
            MysticThinkingView()
                .padding(.leading, 16)
            Spacer()
        }
    }
}

// MARK: - Input Bar
extension SpreadView {
    private var inputBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(Color.navigation.navBarShadow.opacity(0.3))

            HStack(spacing: 10) {
                textField
                sendButton
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .padding(.bottom, bottomPadding)
        }
        .background(Color.main.background)
    }

    private var textField: some View {
        TextField(vm.placeholderText, text: $vm.inputText, axis: .vertical)
            .font(.body)
            .foregroundStyle(Color.main.textFieldText)
            .lineLimit(1...5)
            .focused($isInputFocused)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.navigation.textFieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .onSubmit {
                if vm.canSend { vm.sendQuestion() }
            }
    }

    private var sendButton: some View {
        Button(action: {
            vm.sendQuestion()
            isInputFocused = false
        }) {
            Image.system.sendArrow
                .font(.system(size: 30))
                .foregroundStyle(
                    vm.canSend
                    ? LinearGradient(
                        colors: [Color.navigation.segmentBackgroundPressedOne,
                                 Color.navigation.segmentBackgroundPressedTwo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    : LinearGradient(
                        colors: [Color.main.secondaryText, Color.main.secondaryText],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
        .disabled(!vm.canSend)
        .animation(.easeInOut(duration: 0.2), value: vm.canSend)
    }
}

// MARK: - Mystic Particles Background
private struct MysticParticlesView: View {
    private let particleCount = 20

    var body: some View {
        GeometryReader { geo in
            ForEach(0..<particleCount, id: \.self) { i in
                MysticParticle(
                    size: geo.size,
                    index: i
                )
            }
        }
        .allowsHitTesting(false)
    }
}

private struct MysticParticle: View {
    let size: CGSize
    let index: Int

    @State private var animating = false

    private var particleSize: CGFloat { CGFloat.random(in: 2...5) }
    private var startX: CGFloat { CGFloat.random(in: 0...1) * size.width }
    private var startY: CGFloat { CGFloat.random(in: 0...1) * size.height }
    private var duration: Double { Double.random(in: 4...8) }
    private var delay: Double { Double.random(in: 0...3) }
    private var driftX: CGFloat { CGFloat.random(in: -30...30) }
    private var driftY: CGFloat { CGFloat.random(in: -60 ... -20) }

    var body: some View {
        Circle()
            .fill(
                index % 3 == 0
                ? Color.navigation.segmentBackgroundPressedOne.opacity(0.4)
                : index % 3 == 1
                ? Color.navigation.segmentBackgroundPressedTwo.opacity(0.3)
                : Color.sign.zodiac.opacity(0.25)
            )
            .frame(width: particleSize, height: particleSize)
            .blur(radius: 1)
            .position(
                x: startX + (animating ? driftX : 0),
                y: startY + (animating ? driftY : 0)
            )
            .opacity(animating ? 0 : 0.8)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
                ) {
                    animating = true
                }
            }
    }
}

// MARK: - Mystic Orb (Loading)
private struct MysticOrbView: View {
    @State private var rotating = false
    @State private var glowing = false

    var body: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.navigation.segmentBackgroundPressedTwo.opacity(0.3),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 35
                    )
                )
                .scaleEffect(glowing ? 1.3 : 0.9)
                .animation(
                    .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                    value: glowing
                )

            // Inner ring
            Circle()
                .stroke(
                    AngularGradient(
                        colors: [
                            Color.navigation.segmentBackgroundPressedOne,
                            Color.navigation.segmentBackgroundPressedTwo,
                            Color.sign.zodiac,
                            Color.navigation.segmentBackgroundPressedOne
                        ],
                        center: .center
                    ),
                    lineWidth: 2
                )
                .frame(width: 30, height: 30)
                .rotationEffect(.degrees(rotating ? 360 : 0))
                .animation(
                    .linear(duration: 3).repeatForever(autoreverses: false),
                    value: rotating
                )

            // Center sparkle
            Image.system.sparkle
                .font(.caption)
                .foregroundStyle(Color.sign.zodiac)
                .scaleEffect(glowing ? 1.2 : 0.8)
                .animation(
                    .easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                    value: glowing
                )
        }
        .onAppear {
            rotating = true
            glowing = true
        }
    }
}

// MARK: - Mystic Thinking Indicator
private struct MysticThinkingView: View {
    @State private var phase: CGFloat = 0
    @State private var glowing = false

    var body: some View {
        HStack(spacing: 12) {
            // Mystic icon
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.navigation.segmentBackgroundPressedTwo.opacity(glowing ? 0.4 : 0.1),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 2,
                            endRadius: 20
                        )
                    )
                    .frame(width: 40, height: 40)

                Image.system.sparkles
                    .font(.caption)
                    .foregroundStyle(Color.sign.zodiac)
                    .scaleEffect(glowing ? 1.15 : 0.9)
            }
            .animation(
                .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                value: glowing
            )

            // Animated dots
            HStack(spacing: 6) {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.navigation.segmentBackgroundPressedOne.opacity(0.8),
                                    Color.navigation.segmentBackgroundPressedTwo.opacity(0.8)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 8, height: 8)
                        .scaleEffect(glowing ? 1.3 : 0.7)
                        .opacity(glowing ? 1.0 : 0.4)
                        .animation(
                            .easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(i) * 0.2),
                            value: glowing
                        )
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            LinearGradient(
                colors: [Color.navigation.cellOne, Color.navigation.cellTwo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.navigation.segmentBackgroundPressedTwo.opacity(0.15), radius: 8, x: 0, y: 4)
        .onAppear { glowing = true }
        .onDisappear { glowing = false }
    }
}
