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

extension Card {
    static func getCard() -> [Card] {
        [
            Card(
                title: "Шут",
                image: "Шут",
                element: .air,
                arkan: .major,
                astrology: Astrology(planet: .uranus, zodiac: nil, description: nil),
                numerology: Numerology(number: "0", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Маг",
                image: "Маг",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .mercury, zodiac: nil, description: nil),
                numerology: Numerology(number: "1", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Верховная Жрица",
                image: "Верховная Жрица",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .moon, zodiac: nil, description: nil),
                numerology: Numerology(number: "2", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Императрица",
                image: "Императрица",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .venus, zodiac: nil, description: nil),
                numerology: Numerology(number: "3", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Император",
                image: "Император",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .aries, description: nil),
                numerology: Numerology(number: "4", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Иерофант",
                image: "Иерофант",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .taurus, description: nil),
                numerology: Numerology(number: "5", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Влюблённые",
                image: "Влюблённые",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .gemini, description: nil),
                numerology: Numerology(number: "6", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Колесница",
                image: "Колесница",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .cancer, description: nil),
                numerology: Numerology(number: "7", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Справедливость",
                image: "Справедливость",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .libra, description: nil),
                numerology: Numerology(number: "8", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Отшельник",
                image: "Отшельник",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .virgo, description: nil),
                numerology: Numerology(number: "9", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Колесо Фортуны",
                image: "Колесо Фортуны",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .jupiter, zodiac: nil, description: nil),
                numerology: Numerology(number: "10", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Сила",
                image: "Сила",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .leo, description: nil),
                numerology: Numerology(number: "11", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Повешенный",
                image: "Повешенный",
                element: .water,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: nil, description: nil),
                numerology: Numerology(number: "12", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Смерть",
                image: "Смерть",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .scorpio, description: nil),
                numerology: Numerology(number: "13", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Умеренность",
                image: "Умеренность",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .sagittarius, description: nil),
                numerology: Numerology(number: "14", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Дьявол",
                image: "Дьявол",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .capricorn, description: nil),
                numerology: Numerology(number: "15", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Башня",
                image: "Башня",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .mars, zodiac: nil, description: nil),
                numerology: Numerology(number: "16", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Звезда",
                image: "Звезда",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .aquarius, description: nil),
                numerology: Numerology(number: "17", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Луна",
                image: "Луна",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: nil, zodiac: .pisces, description: nil),
                numerology: Numerology(number: "18", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Солнце",
                image: "Солнце",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .sun, zodiac: nil, description: nil),
                numerology: Numerology(number: "19", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Суд",
                image: "Суд",
                element: .fire,
                arkan: .major,
                astrology: Astrology(planet: .pluto, zodiac: nil, description: nil),
                numerology: Numerology(number: "20", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Мир",
                image: "Мир",
                element: nil,
                arkan: .major,
                astrology: Astrology(planet: .saturn, zodiac: nil, description: nil),
                numerology: Numerology(number: "21", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Туз Посохов",
                image: "Туз Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "1", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Двойка Посохов",
                image: "Двойка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "2", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Тройка Посохов",
                image: "Тройка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "3", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Четвёрка Посохов",
                image: "Четвёрка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "4", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Пятёрка Посохов",
                image: "Пятёрка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "5", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Шестёрка Посохов",
                image: "Шестёрка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "6", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Семёрка Посохов",
                image: "Семёрка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "7", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Восьмёрка Посохов",
                image: "Восьмёрка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "8", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Девятка Посохов",
                image: "Девятка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "9", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Десятка Посохов",
                image: "Десятка Посохов",
                element: .fire,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "10", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Туз Мечей",
                image: "Туз Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "1", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Двойка Мечей",
                image: "Двойка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "2", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Тройка Мечей",
                image: "Тройка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "3", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Четвёрка Мечей",
                image: "Четвёрка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "4", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Пятёрка Мечей",
                image: "Пятёрка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "5", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Шестёрка Мечей",
                image: "Шестёрка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "6", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Семёрка Мечей",
                image: "Семёрка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "7", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Восьмёрка Мечей",
                image: "Восьмёрка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "8", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Девятка Мечей",
                image: "Девятка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "9", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Десятка Мечей",
                image: "Десятка Мечей",
                element: .air,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "10", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Туз Кубков",
                image: "Туз Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "1", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Двойка Кубков",
                image: "Двойка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "2", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Тройка Кубков",
                image: "Тройка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "3", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Четвёрка Кубков",
                image: "Четвёрка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "4", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Пятёрка Кубков",
                image: "Пятёрка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "5", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Шестёрка Кубков",
                image: "Шестёрка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "6", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Семёрка Кубков",
                image: "Семёрка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "7", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Восьмёрка Кубков",
                image: "Восьмёрка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "8", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Девятка Кубков",
                image: "Девятка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "9", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Десятка Кубков",
                image: "Десятка Кубков",
                element: .water,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "10", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Туз Пентаклей",
                image: "Туз Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "1", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Двойка Пентаклей",
                image: "Двойка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "2", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Тройка Пентаклей",
                image: "Тройка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "3", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Четвёрка Пентаклей",
                image: "Четвёрка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "4", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Пятёрка Пентаклей",
                image: "Пятёрка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "5", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Шестёрка Пентаклей",
                image: "Шестёрка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "6", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Семёрка Пентаклей",
                image: "Семёрка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "7", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Восьмёрка Пентаклей",
                image: "Восьмёрка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "8", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Девятка Пентаклей",
                image: "Девятка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "9", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Десятка Пентаклей",
                image: "Десятка Пентаклей",
                element: .earth,
                arkan: .minor,
                astrology: nil,
                numerology: Numerology(number: "10", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Паж Посохов",
                image: "Паж Посохов",
                element: .fire,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Рыцарь Посохов",
                image: "Рыцарь Посохов",
                element: .fire,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Королева Посохов",
                image: "Королева Посохов",
                element: .fire,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Король Посохов",
                image: "Король Посохов",
                element: .fire,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Паж Мечей",
                image: "Паж Мечей",
                element: .air,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Рыцарь Мечей",
                image: "Рыцарь Мечей",
                element: .air,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Королева Мечей",
                image: "Королева Мечей",
                element: .air,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Король Мечей",
                image: "Король Мечей",
                element: .air,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Паж Кубков",
                image: "Паж Кубков",
                element: .water,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Рыцарь Кубков",
                image: "Рыцарь Кубков",
                element: .water,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Королева Кубков",
                image: "Королева Кубков",
                element: .water,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Король Кубков",
                image: "Король Кубков",
                element: .water,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Паж Пентаклей",
                image: "Паж Пентаклей",
                element: .earth,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Рыцарь Пентаклей",
                image: "Рыцарь Пентаклей",
                element: .earth,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Королева Пентаклей",
                image: "Королева Пентаклей",
                element: .earth,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            ),
            Card(
                title: "Король Пентаклей",
                image: "Король Пентаклей",
                element: .earth,
                arkan: .court,
                astrology: nil,
                numerology: Numerology(number: "No value", descriptions: nil),
                filosophy: nil,
                mainMeaning: nil,
                personalityCharacterization: nil,
                answer: nil
            )
        ]
    }
}
