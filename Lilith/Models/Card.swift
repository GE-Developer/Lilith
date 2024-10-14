//
//  Full Card Model.swift
//  Tarot
//
//  Created by Mikhail Bukhrashvili on 25.08.24.
//

import Foundation

struct Card: Identifiable {
    var id: String {
        title
    }
    
    let title: String // Назание
    let image: String // Фото карты
    let element: Element?
    let arkan: Arcana // Арканы
    let astrology: Astrology? // Астрология
    let numerology: Numerology // Нумерология
    let filosophy: Filosophy? // Философия
    let mainMeaning: String? // Значение
    let personalityCharacterization: [PersonalityCharacterization]? // Хар. личности
    let answer: String?
}

// Доп модели -----

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
