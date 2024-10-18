//
//  Image + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

extension Image {
    static let system = SystemImage()
}

struct SystemImage {
    let magnifyingglass = Image(systemName: "magnifyingglass")
    let xmark = Image(systemName: "xmark")
    let heart = Image(systemName: "heart")
    let heartFill = Image(systemName: "heart.fill")
    let bin = Image(systemName: "xmark.bin")
    let binFill = Image(systemName: "xmark.bin.fill")
}
