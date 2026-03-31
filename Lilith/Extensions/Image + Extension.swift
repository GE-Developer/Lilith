//
//  Image + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

extension Image {
    static let system = SystemImage()
    static let cardBackside = CardBacksideImage()
    static let custom = CustomImage()
}

struct SystemImage {
    let magnifyingglass = Image(systemName: "magnifyingglass")
    let xmark = Image(systemName: "xmark")
    let heart = Image(systemName: "heart")
    let heartFill = Image(systemName: "heart.fill")
    let binFill = Image(systemName: "xmark.bin.fill")
    let circle = Image(systemName: "circle")
    let chechmark = Image(systemName: "checkmark.circle.fill")
    let rotationImage = Image(systemName: "rectangle.portrait.rotate")
    let chevron = Image(systemName: "chevron.right")
    let back = Image(systemName: "chevron.left")
    
    let darkMode = Image(systemName: "moon.fill")
    let language = Image(systemName: "globe")
    let vibration = Image(systemName: "iphone.radiowaves.left.and.right")
    let sound = Image(systemName: "speaker.wave.2.fill")
    let notifications = Image(systemName: "bell.badge.fill")
    let subscription = Image(systemName: "star")
    let restorePurchases = Image(systemName: "arrow.clockwise")
    let reviewLike = Image(systemName: "hand.thumbsup.fill")
    let clearHistory = Image(systemName: "clock.arrow.circlepath")
    let resetAllSettings = Image(systemName: "exclamationmark.triangle.fill")
    let rectangle = Image(systemName: "app.fill")
    let music = Image(systemName: "music.note")
    let termsOfUse = Image(systemName: "doc.plaintext")
    let privacyPolicy = Image(systemName: "lock.doc.fill")
    let developerTool = Image(systemName: "hammer.fill")
    let code = Image(systemName: "chevron.left.slash.chevron.right")
    let betaFeatures = Image(systemName: "rectangle.3.offgrid")
    let earlyAccess = Image(systemName: "eye")

    let gearshape = Image(systemName: "gearshape.fill")
    let starFill = Image(systemName: "star.fill")
    let lockOpen = Image(systemName: "lock.open.fill")
    let lockClosed = Image(systemName: "lock.fill")
    let sparkle = Image(systemName: "sparkle")
    let sparkles = Image(systemName: "sparkles")
    let info = Image(systemName: "info")
    let sendArrow = Image(systemName: "arrow.up.circle.fill")
    let decksCard = Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
    let number = Image(systemName: "number")
    let checklist = Image(systemName: "checklist")
    let starCircle = Image(systemName: "star.circle")
    let envelopeOpen = Image(systemName: "envelope.open.fill")
    let wifiSlash = Image(systemName: "wifi.slash")
}

struct CardBacksideImage {
    let galacticEcho = Image("Galactic Echo")
    let moonShadow = Image("Moon's Shadow")
}

struct CustomImage {
    let archetype = Image("Archetype")
    let moonTexture = UIImage(named: "MoonTexture")
}
