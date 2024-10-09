//
//  Extension + Color.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 03.09.24.
//

import SwiftUI

extension Color {
    static let main = MainTheme()
    static let sign = SignsTheme()
    static let navigation = NavigationTheme()
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
    let likeButtonBackground = Color("Like Button Background")
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
}
