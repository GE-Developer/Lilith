//
//  LikedCard.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 09.10.24.
//

import SwiftData

@Model
final class LikedCard {
    var id: String = ""
    
    init(_ id: String) {
        self.id = id
    }
}
