//
//  ClassicCard.swift
//  Lilith
//
//  Created by GE-Developer
//

protocol CardsInfoProtocol {
    var id: String { get }
    var title: String { get }
    var subTitle: String { get }
    var description: String { get }
    var cards: [Card] { get }
}

final class ClassicCard: CardsInfoProtocol, Identifiable {
    let id = "Rider Waite"
    let title = L10n.Deck.ClassicCard.title
    let subTitle = L10n.Deck.ClassicCard.subTitle
    let description = ""
    
    let cards: [Card] = [
        Card(
            id: "RIDER WAITE - СLASSIC - THE FOOL",
            title: L10n.Deck.ClassicCard.Card.TheFool.title,
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
            id: "RIDER WAITE - СLASSIC - THE MAGICIAN",
            title: L10n.Deck.ClassicCard.Card.TheMagician.title,
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
            id: "RIDER WAITE - СLASSIC - THE HIGH PRIESTESS",
            title: L10n.Deck.ClassicCard.Card.TheHighPriestess.title,
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
            id: "RIDER WAITE - СLASSIC - THE EMPRESS",
            title: L10n.Deck.ClassicCard.Card.TheEmpress.title,
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
            id: "RIDER WAITE - СLASSIC - THE EMPEROR",
            title: L10n.Deck.ClassicCard.Card.TheEmperor.title,
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
            id: "RIDER WAITE - СLASSIC - THE HIEROPHANT",
            title: L10n.Deck.ClassicCard.Card.TheHierophant.title,
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
            id: "RIDER WAITE - СLASSIC - THE LOVERS",
            title: L10n.Deck.ClassicCard.Card.TheLovers.title,
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
            id: "RIDER WAITE - СLASSIC - THE CHARIOT",
            title: L10n.Deck.ClassicCard.Card.TheChariot.title,
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
            id: "RIDER WAITE - СLASSIC - STRENGTH",
            title: L10n.Deck.ClassicCard.Card.Strength.title,
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
            id: "RIDER WAITE - СLASSIC - THE HERMIT",
            title: L10n.Deck.ClassicCard.Card.TheHermit.title,
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
            id: "RIDER WAITE - СLASSIC - WHEEL OF FORTUNE",
            title: L10n.Deck.ClassicCard.Card.WheelOfFortune.title,
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
            id: "RIDER WAITE - СLASSIC - JUSTICE",
            title: L10n.Deck.ClassicCard.Card.Justice.title,
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
            id: "RIDER WAITE - СLASSIC - THE HANGED MAN",
            title: L10n.Deck.ClassicCard.Card.TheHangedMan.title,
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
            id: "RIDER WAITE - СLASSIC - DEATH",
            title: L10n.Deck.ClassicCard.Card.Death.title,
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
            id: "RIDER WAITE - СLASSIC - TEMPERANCE",
            title: L10n.Deck.ClassicCard.Card.Temperance.title,
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
            id: "RIDER WAITE - СLASSIC - THE DEVIL",
            title: L10n.Deck.ClassicCard.Card.TheDevil.title,
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
            id: "RIDER WAITE - СLASSIC - THE TOWER",
            title: L10n.Deck.ClassicCard.Card.TheTower.title,
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
            id: "RIDER WAITE - СLASSIC - THE STAR",
            title: L10n.Deck.ClassicCard.Card.TheStar.title,
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
            id: "RIDER WAITE - СLASSIC - THE MOON",
            title: L10n.Deck.ClassicCard.Card.TheMoon.title,
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
            id: "RIDER WAITE - СLASSIC - THE SUN",
            title: L10n.Deck.ClassicCard.Card.TheSun.title,
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
            id: "RIDER WAITE - СLASSIC - JUDGEMENT",
            title: L10n.Deck.ClassicCard.Card.Judgement.title,
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
            id: "RIDER WAITE - СLASSIC - THE WORLD",
            title: L10n.Deck.ClassicCard.Card.TheWorld.title,
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
            id: "RIDER WAITE - СLASSIC - ACE OF WANDS",
            title: L10n.Deck.ClassicCard.Card.AceOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - TWO OF WANDS",
            title: L10n.Deck.ClassicCard.Card.TwoOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - THREE OF WANDS",
            title: L10n.Deck.ClassicCard.Card.ThreeOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - FOUR OF WANDS",
            title: L10n.Deck.ClassicCard.Card.FourOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - FIVE OF WANDS",
            title: L10n.Deck.ClassicCard.Card.FiveOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - SIX OF WANDS",
            title: L10n.Deck.ClassicCard.Card.SixOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - SEVEN OF WANDS",
            title: L10n.Deck.ClassicCard.Card.SevenOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - EIGHT OF WANDS",
            title: L10n.Deck.ClassicCard.Card.EightOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - NINE OF WANDS",
            title: L10n.Deck.ClassicCard.Card.NineOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - TEN OF WANDS",
            title: L10n.Deck.ClassicCard.Card.TenOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - ACE OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.AceOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - TWO OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.TwoOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - THREE OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.ThreeOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - FOUR OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.FourOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - FIVE OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.FiveOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - SIX OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.SixOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - SEVEN OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.SevenOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - EIGHT OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.EightOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - NINE OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.NineOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - TEN OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.TenOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - ACE OF CUPS",
            title: L10n.Deck.ClassicCard.Card.AceOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - TWO OF CUPS",
            title: L10n.Deck.ClassicCard.Card.TwoOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - THREE OF CUPS",
            title: L10n.Deck.ClassicCard.Card.ThreeOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - FOUR OF CUPS",
            title: L10n.Deck.ClassicCard.Card.FourOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - FIVE OF CUPS",
            title: L10n.Deck.ClassicCard.Card.FiveOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - SIX OF CUPS",
            title: L10n.Deck.ClassicCard.Card.SixOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - SEVEN OF CUPS",
            title: L10n.Deck.ClassicCard.Card.SevenOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - EIGHT OF CUPS",
            title: L10n.Deck.ClassicCard.Card.EightOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - NINE OF CUPS",
            title: L10n.Deck.ClassicCard.Card.NineOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - TEN OF CUPS",
            title: L10n.Deck.ClassicCard.Card.TenOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - ACE OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.AceOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - TWO OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.TwoOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - THREE OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.ThreeOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - FOUR OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.FourOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - FIVE OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.FiveOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - SIX OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.SixOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - SEVEN OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.SevenOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - EIGHT OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.EightOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - NINE OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.NineOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - TEN OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.TenOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - PAGE OF WANDS",
            title: L10n.Deck.ClassicCard.Card.PageOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - KNIGHT OF WANDS",
            title: L10n.Deck.ClassicCard.Card.KnightOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - QUEEN OF WANDS",
            title: L10n.Deck.ClassicCard.Card.QueenOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - KING OF WANDS",
            title: L10n.Deck.ClassicCard.Card.KingOfWands.title,
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
            id: "RIDER WAITE - CLASSIC - PAGE OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.PageOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - KNIGHT OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.KnightOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - QUEEN OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.QueenOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - KING OF SWORDS",
            title: L10n.Deck.ClassicCard.Card.KingOfSwords.title,
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
            id: "RIDER WAITE - CLASSIC - PAGE OF CUPS",
            title: L10n.Deck.ClassicCard.Card.PageOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - KNIGHT OF CUPS",
            title: L10n.Deck.ClassicCard.Card.KnightOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - QUEEN OF CUPS",
            title: L10n.Deck.ClassicCard.Card.QueenOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - KING OF CUPS",
            title: L10n.Deck.ClassicCard.Card.KingOfCups.title,
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
            id: "RIDER WAITE - CLASSIC - PAGE OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.PageOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - KNIGHT OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.KnightOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - QUEEN OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.QueenOfPentacles.title,
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
            id: "RIDER WAITE - CLASSIC - KING OF PENTACLES",
            title: L10n.Deck.ClassicCard.Card.KingOfPentacles.title,
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
