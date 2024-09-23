//
//  Full Card Model.swift
//  Tarot
//
//  Created by Mikhail Bukhrashvili on 25.08.24.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let title: String // Назание
    let image: String // Фото карты
    let element: Element?
    let arkan: Arkan // Арканы
    let astrology: Astrology? // Астрология
    let numerology: Numerology // Нумерология
    let filosophy: Filosophy? // Философия
    let mainMeaning: String? // Значение
    let personalityCharacterization: [PersonalityCharacterization]? // Хар. личности
    let answer: Answer?
}

// Доп модели -----
enum Arkan: String, Hashable, CaseIterable {
    case all
    case major = "Старший Аркан"
    case minor = "Младший Аркан"
    case court = "Придворный Аркан"
    
    var plural: String {
        switch self {
        case .major: return "Старшие Арканы"
        case .minor: return "Младшие Арканы"
        case .court: return "Придворные Арканы"
        case .all:   return "Все Арканы"
        }
    }
    
    var shortPlural: String {
        switch self {
        case .major: return "Старшие"
        case .minor: return "Младшие"
        case .court: return "Придворные"
        case .all:   return "Все"
        }
    }
}

enum Element: String, Hashable, CaseIterable {
    case fire = "Огонь"
    case water = "Вода"
    case earth = "Земля"
    case air = "Воздух"
}

enum Zodiac: String, Hashable, CaseIterable {
    case aries = "Овен"
    case taurus = "Телец"
    case gemini = "Близнецы"
    case cancer = "Рак"
    case leo = "Лев"
    case virgo = "Дева"
    case libra = "Весы"
    case scorpio = "Скорпион"
    case sagittarius = "Стрелец"
    case capricorn = "Козерог"
    case aquarius = "Водолей"
    case pisces = "Рыбы"
}

enum Planet: String, Hashable, CaseIterable {
    case uranus = "Уран"
    case mercury = "Меркурий"
    case moon = "Луна"
    case venus = "Венера"
    case jupiter = "Юпитер"
    case mars = "Марс"
    case sun = "Солнце"
    case pluto = "Плутон"
    case saturn = "Сатурн"
}

struct Astrology {
    let name = "Астрология"
    let planet: Planet? // Планета
    let zodiac: Zodiac?
    let description: String? // Описание
}

struct Numerology {
    let name = "Нумерология"
    let number: String // Номер
    let descriptions: [String]? // Описание
    
    var romanNumber: String {
        let romanSymbols = [
            "0": "0",
            "1": "I",
            "2": "II",
            "3": "III",
            "4": "IV",
            "5": "V",
            "6": "VI",
            "7": "VII",
            "8": "VIII",
            "9": "IX",
            "10": "X",
            "11": "XI",
            "12": "XII",
            "13": "XIII",
            "14": "XIV",
            "15": "XV",
            "16": "XVI",
            "17": "XVII",
            "18": "XVIII",
            "19": "XIX",
            "20": "XX",
            "21": "XXI",
            ""  : ""
        ]
        return romanSymbols[number] ?? ""
    }
}

struct Filosophy {
    let name = "Философия"
    let description: String // Описание
    let meaning: String // Смысл
    let glifs: [Glif] // Глифы
}

struct Glif {
    let imageDescription: String // Описание изображения
    let meaning: String // Смысл
}

struct PersonalityCharacterization {
    let name = "Характеристика личности"
    let polarity: Bool // + или -
    let description: String // Описание
}

struct Answer {
    let themeDescription: [AnswerTheme: [String]]
}

enum AnswerTheme {
    case love
    case finance
    case healt
    case lessonAndCaution
    case negativeMeaning
}
