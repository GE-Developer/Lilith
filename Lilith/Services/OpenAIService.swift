//
//  OpenAIService.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

final class OpenAIService: @unchecked Sendable {
    static let shared = OpenAIService()

    // MARK: - API Key
    private let apiKey: String = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["OPENAI_API_KEY"] as? String
        else {
            fatalError("Secrets.plist not found or OPENAI_API_KEY missing")
        }
        return key
    }()

    // MARK: - Models

    struct ChatMessage: Codable {
        let role: String    // "system" | "user" | "assistant"
        let content: String
    }

    enum GPTResponse {
        case clarify(message: String)
        case spread(card1: String, card2: String, card3: String, summary: String)
        case reply(message: String)
        case newSpread
    }

    // MARK: - System Prompt

    private let systemPrompt = """
    Ты — мистический таролог. Ведёшь диалог с пользователем в чате.

    ФАЗА 1 — до расклада:
    Анализируй вопрос пользователя. Если он слишком размытый или требует уточнения — задай ровно ОДИН уточняющий вопрос. Задавай не более двух уточнений подряд, после чего в любом случае делай расклад.
    Когда вопрос достаточно конкретен — делай расклад.

    ФАЗА 2 — после расклада:
    Отвечай на вопросы пользователя, опираясь на выданные карты и их интерпретацию. Будь развёрнутым, мистичным и глубоким.
    Если пользователь просит новый расклад, другой вопрос или хочет начать заново — отвечай action new_spread.

    ВСЕГДА отвечай строго в формате JSON, без лишнего текста снаружи.

    Уточняющий вопрос:
    {"action":"clarify","message":"твой вопрос"}

    Расклад:
    {"action":"spread","card1":"интерпретация — прошлое / корень / основа","card2":"интерпретация — настоящее / суть / то что происходит","card3":"интерпретация — будущее / совет / к чему идти","summary":"общий итог расклада — синтез трёх карт, 3–5 предложений"}

    Ответ после расклада:
    {"action":"reply","message":"твой ответ в контексте карт"}

    Новый расклад:
    {"action":"new_spread"}

    Пиши на языке пользователя. Интерпретации — 2–4 предложения каждая, образно и глубоко.
    """

    private init() {}

    // MARK: - Send

    func send(history: [ChatMessage]) async throws -> GPTResponse {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let systemMessage = ChatMessage(role: "system", content: systemPrompt)
        let allMessages = [systemMessage] + history

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "response_format": ["type": "json_object"],
            "messages": allMessages.map { ["role": $0.role, "content": $0.content] },
            "temperature": 0.85
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenAIError.badResponse(code: -1)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw OpenAIError.badResponse(code: httpResponse.statusCode)
        }

        return try parseResponse(data)
    }

    // MARK: - Parse

    private func parseResponse(_ data: Data) throws -> GPTResponse {
        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let choices = json["choices"] as? [[String: Any]],
            let first = choices.first,
            let message = first["message"] as? [String: Any],
            let content = message["content"] as? String,
            let contentData = content.data(using: .utf8),
            let parsed = try JSONSerialization.jsonObject(with: contentData) as? [String: Any],
            let action = parsed["action"] as? String
        else {
            throw OpenAIError.parseError
        }

        switch action {
        case "clarify":
            guard let msg = parsed["message"] as? String else { throw OpenAIError.parseError }
            return .clarify(message: msg)

        case "spread":
            guard
                let c1 = parsed["card1"] as? String,
                let c2 = parsed["card2"] as? String,
                let c3 = parsed["card3"] as? String
            else { throw OpenAIError.parseError }
            let summary = parsed["summary"] as? String ?? ""
            return .spread(card1: c1, card2: c2, card3: c3, summary: summary)

        case "reply":
            guard let msg = parsed["message"] as? String else { throw OpenAIError.parseError }
            return .reply(message: msg)

        case "new_spread":
            return .newSpread

        default:
            throw OpenAIError.parseError
        }
    }
}

// MARK: - Errors

enum OpenAIError: LocalizedError {
    case badResponse(code: Int)
    case parseError

    var errorDescription: String? {
        switch self {
        case .badResponse(let code): return L10n("Error.serverError", code)
        case .parseError:            return L10n("Error.parseError")
        }
    }
}
