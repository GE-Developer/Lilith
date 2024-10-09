//
//  CarsViewModel.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 05.10.24.
//

import Foundation

final class CarsViewModel: ObservableObject {
    let title: String
    let cars: [CarModel]
    
    private let storage: CarStorageManager
    
    @Published var dataCars: [Car] = []
    
    init(_ carData: CarInfoProtocol, storage: CarStorageManager) {
        title = carData.title.uppercased()
        cars = carData.cars
        self.storage = storage
        
        fetch()
    }
    
    private func fetch() {
        storage.fetch { result in
            switch result {
            case .success(let cars):
                dataCars = cars
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func create(_ id: String) {
        storage.create(id) { car in
            dataCars.append(car)
        }
    }
    
    func deleteAll() {
        storage.deleteAll()
        fetch()
    }
    
    func count(_ car: CarModel) -> String {
        dataCars.filter { $0.id == car.id }.count.formatted()
    }
}
