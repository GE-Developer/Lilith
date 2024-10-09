//
//  ClassicCar.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 05.10.24.
//

import Foundation

protocol CarInfoProtocol {
    var title: String { get }
    var cars: [CarModel] { get }
}

final class ClassicCar: CarInfoProtocol {
    let title = "Классика"
    let cars: [CarModel] = [
        CarModel(id: "BMW2012", model: "BMW", year: "2012"),
        CarModel(id: "Mercedes2017", model: "Mercedes", year: "2017"),
        CarModel(id: "Toyota2007", model: "Toyota", year: "2007")
    ]
}
