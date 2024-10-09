//
//  Car.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 05.10.24.
//

import Foundation
import SwiftData

struct CarModel: Identifiable {
    let id: String
    
    let model: String
    let year: String
}

@Model
final class Car {
    var id: String
    
    init(id: String = "") {
        self.id = id
    }
}
