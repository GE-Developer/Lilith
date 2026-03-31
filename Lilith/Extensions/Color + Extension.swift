//
//  Color + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

extension Color {
    static let main = MainTheme()
    static let sign = SignsTheme()
    static let navigation = NavigationTheme()
    static let subscription = SubscriptionStatusTheme()
    static let home = HomeTheme()
    static let moon = MoonTheme()
}

struct MainTheme {
    let viewShadow = Color("View Shadow")
    let background = Color("Background")
    let textFieldText = Color("Text Field Text")
    let titleText = Color("Title Text")
    let text = Color("Text")
    let secondaryText = Color("Secondary Text")
}

struct NavigationTheme {
    let navBarShadow = Color("NavBarShadow")
    
    let title = Color("Title")
    let secondaryTitle = Color("Secondary Title")
    let backButton = Color("Back Button")
    let buttonBackground = Color("Like Button Background")
    let heartOne = Color("Heart One")
    let heartTwo = Color("Heart Two")
    let cancelButton = Color("Cancel Button")
    let magnifying = Color("Magnifying")
    let focusedMagnifying = Color("Focused Magnifying")
    let textFieldBackground = Color("Text Field Background")
    let segmentText = Color("Segment Text")
    let segmentTextPressed = Color("Segment Text Pressed")
    let segmentBackgroundPressedOne = Color("Segment Background Pressed One")
    let segmentBackgroundPressedTwo = Color("Segment Background Pressed Two")
    let segmentBackground = Color("Segment Background")
    let cellOne = Color("Cell One")
    let cellTwo = Color("Cell Two")
    let romanBackground = Color("Roman Background")
}

struct SignsTheme {
    let shadow = Color("Sign Shadow")
    
    // Element
    let water = Color("Water")
    let fire = Color("Fire")
    let air = Color("Air")
    let earth = Color("Earth")
    
    // Zodiac
    let zodiac = Color("Zodiac")
    
    // Planet
    let planet = Color("Planet")
    
    // Roman
    let romanText = Color("Roman Text")
    
    // Archetype
    let archtype = Color("Archetype")
}

struct SubscriptionStatusTheme {
    let bannerText = Color("Subscribtion Banner Text")
    let premiumOne = Color("PremiumSubscriptionOne")
    let premiumTwo = Color("PremiumSubscriptionTwo")
    let basicOne = Color("BasicSubscriptionOne")
    let basicTwo = Color("BasicSubscriptionTwo")
}

struct HomeTheme {
    let background = Color.black
    let star = Color.white
    let overlay = Color.black.opacity(0.5)
    let destructive = Color.red
    let toggleCircle = Color.white
    let tileOrangeOne = Color(red: 0.95, green: 0.55, blue: 0.15)
    let tileOrangeTwo = Color(red: 0.75, green: 0.30, blue: 0.05)
    let tileAmberOne = Color(red: 0.90, green: 0.45, blue: 0.10)
    let tileAmberTwo = Color(red: 0.65, green: 0.22, blue: 0.0)
}

struct MoonTheme {
    let materialAmbient = UIColor(white: 0.08, alpha: 1)
    let materialSpecular = UIColor(white: 0.05, alpha: 1)
    let directionalLight = UIColor(white: 0.85, alpha: 1)
    let ambientLight = UIColor(white: 0.4, alpha: 1)
    let accentOne = UIColor(red: 1.0, green: 0.016, blue: 0.403, alpha: 1.0)
    let accentTwo = UIColor(red: 0.663, green: 0.0, blue: 0.352, alpha: 1.0)
    let accentMix = UIColor(red: 0.83, green: 0.008, blue: 0.378, alpha: 1.0)
}
