//
//  CarStorageManager.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 08.10.24.
//

import SwiftData

//import CoreData
//final class CarStorageManager {
//    @MainActor static let shared = CarStorageManager()
//    
//    private let persistentContainer = {
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores { _, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//        return container
//    }()
//    
//    private let viewContext: NSManagedObjectContext
//    
//    private init() {
//        viewContext = persistentContainer.viewContext
//    }
//    
//    func create(_ id: String, completion: (Car) -> Void) {
//        let car = Car(context: viewContext)
//        car.id = id
//        completion(car)
//        saveContext()
//        
//        print("Создано")
//    }
//    
//    func fetchData(completion: (Result<[Car], Error>) -> Void) {
//        let fetchRequest = Car.fetchRequest()
//        
//        do {
//            let tasks = try viewContext.fetch(fetchRequest)
//            completion(.success(tasks))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
////    func update(_ car: Car, id: String) {
////        car.id = id
////        saveContext()
////    }
//    
//    func delete(_ car: Car) {
//        viewContext.delete(car)
//        saveContext()
//        
//        print("Удалено")
//    }
//    
//    func saveContext() {
//        if viewContext.hasChanges {
//            do {
//                try viewContext.save()
//            } catch {
//                let error = error as NSError
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//    }
//    
//    func deleteAll() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Car.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        do {
//            try viewContext.execute(deleteRequest)
//            saveContext()
//            print("Все машины удалены")
//        } catch let error as NSError {
//            print("Ошибка при удалении всех машин: \(error), \(error.userInfo)")
//        }
//        
//    }
//    
//    func printAllCars() {
//        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
//        
//        do {
//            let cars = try viewContext.fetch(fetchRequest)
//            
//            print(cars.count.formatted()) // Печатаем всю информацию сразу
//        } catch let error as NSError {
//            print("Ошибка при получении машин: \(error), \(error.userInfo)")
//        }
//    }
//}

final class CarStorageManager {
    @MainActor static let shared = CarStorageManager()
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    private let fetchDescriptor = FetchDescriptor<Car>()
    
    @MainActor
    private init() {
        modelContainer = try! ModelContainer(for: Car.self)
        modelContext = modelContainer.mainContext
    }
    
    // MARK: - Create
    func create(_ id: String, completion: (Car) -> Void) {
        let newCar = Car(id: id)
        modelContext.insert(newCar)
        save()
        completion(newCar)
    }
    
    // MARK: - Fetch Data
    func fetch(completion: (Result<[Car], Error>) -> Void) {
        do {
            let cars = try modelContext.fetch(fetchDescriptor)
            completion(.success(cars))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Delete
    func delete(_ car: Car) {
        modelContext.delete(car)
        save()
    }
    
    // MARK: - DeleteAll
    func deleteAll() {
        do {
            let allCars = try modelContext.fetch(fetchDescriptor)
            allCars.forEach { modelContext.delete($0) }
            save()
        } catch {
            print("Ошибка при удалении всех объектов: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Save
    func save() {
        if modelContext.hasChanges {
            do {
                try modelContext.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    }
}
