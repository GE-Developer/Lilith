//
//  SpreadViewModel.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

// MARK: - Models

struct SpreadMessage: Identifiable {
    let id = UUID()
    let type: SpreadMessageType
}

enum SpreadMessageType {
    case question(String)
    case aiMessage(String)
    case cards([Card], card1: String, card2: String, card3: String, summary: String)
}

// MARK: - ViewModel

@MainActor
@Observable
final class SpreadViewModel {

    let screenTitle = L10n("UI.Spread.title")
    let placeholderText = L10n("UI.Spread.placeholder")

    var inputText: String = ""
    private(set) var messages: [SpreadMessage] = []
    private(set) var isThinking: Bool = false
    private(set) var loadingState: LoadingState = .idle

    var canSend: Bool {
        !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isThinking
    }

    private let dataService = JSONDataService.shared
    private let openAI = OpenAIService.shared
    private var allCards: [Card] = []
    private var conversationHistory: [OpenAIService.ChatMessage] = []
    private var spreadGiven: Bool = false

    // MARK: - Data Loading

    func loadCards() {
        guard case .idle = loadingState else { return }
        loadingState = .loading

        let decks = dataService.getDecks()
        guard let deck = decks.filter({ $0.isPublished ?? false }).first else {
            loadingState = .failure
            return
        }

        allCards = (deck.arcanaTypes ?? []).flatMap { $0.cards ?? [] }
        loadingState = .success

        showGreeting()
    }

    // MARK: - Greeting

    private func showGreeting() {
        let greetings = [
            L10n("UI.Spread.greeting1"),
            L10n("UI.Spread.greeting2"),
            L10n("UI.Spread.greeting3"),
            L10n("UI.Spread.greeting4")
        ]
        let greeting = greetings.randomElement() ?? greetings[0]
        messages.append(SpreadMessage(type: .aiMessage(greeting)))
    }

    // MARK: - Send

    func sendQuestion() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !isThinking else { return }

        inputText = ""
        HapticsManager.shared.impact(style: .medium)

        messages.append(SpreadMessage(type: .question(text)))
        conversationHistory.append(.init(role: "user", content: text))

        Task {
            isThinking = true
            await askGPT()
            isThinking = false
        }
    }

    // MARK: - GPT

    private func askGPT() async {
        do {
            let response = try await openAI.send(history: conversationHistory)

            switch response {

            case .clarify(let message):
                let assistantJson = "{\"action\":\"clarify\",\"message\":\"\(message.escaped)\"}"
                conversationHistory.append(.init(role: "assistant", content: assistantJson))
                messages.append(SpreadMessage(type: .aiMessage(message)))
                HapticsManager.shared.impact(style: .light)

            case .spread(let c1, let c2, let c3, let summary):
                let picked = Array(allCards.shuffled().prefix(3))

                let cardsNote = "Выпавшие карты: 1) \(picked[safe: 0]?.title ?? "—"), 2) \(picked[safe: 1]?.title ?? "—"), 3) \(picked[safe: 2]?.title ?? "—")"
                let assistantJson = "{\"action\":\"spread\",\"card1\":\"\(c1.escaped)\",\"card2\":\"\(c2.escaped)\",\"card3\":\"\(c3.escaped)\",\"summary\":\"\(summary.escaped)\"}"
                conversationHistory.append(.init(role: "assistant", content: assistantJson))
                conversationHistory.append(.init(role: "system", content: cardsNote))

                messages.append(SpreadMessage(type: .cards(picked, card1: c1, card2: c2, card3: c3, summary: summary)))
                spreadGiven = true
                HapticsManager.shared.notification(type: .success)

            case .reply(let message):
                let assistantJson = "{\"action\":\"reply\",\"message\":\"\(message.escaped)\"}"
                conversationHistory.append(.init(role: "assistant", content: assistantJson))
                messages.append(SpreadMessage(type: .aiMessage(message)))
                HapticsManager.shared.impact(style: .light)

            case .newSpread:
                conversationHistory.removeAll()
                spreadGiven = false
                let newSpreadText = L10n("UI.Spread.newSpread")
                messages.append(SpreadMessage(type: .aiMessage(newSpreadText)))
                HapticsManager.shared.impact(style: .rigid)
            }

        } catch {
            let errorText = "\(L10n("UI.Spread.error")): \(error.localizedDescription)"
            messages.append(SpreadMessage(type: .aiMessage(errorText)))
        }
    }
}

// MARK: - Helpers

private extension String {
    var escaped: String {
        replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "\n", with: "\\n")
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
