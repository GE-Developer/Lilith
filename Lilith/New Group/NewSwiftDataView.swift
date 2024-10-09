//
//  NewSwiftDataView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 05.10.24.
//

import SwiftUI

struct NewSwiftDataView: View {
    @StateObject private var vm = CarsViewModel(ClassicCar(), storage: .shared)
    
    
    var body: some View {
        VStack {
            Form {
                ForEach(vm.cars, id: \.id) { car in
                    Button {
                        vm.create(car.id)
                        
                    } label: {
                        HStack(alignment: .firstTextBaseline) {
                            Text(car.model)
                            Text(car.year)
                            Text(vm.count(car))
                                .foregroundStyle(.red)
                            
                        }
                        .foregroundStyle(.primary)
                    }
                }
                Button("Удалить все") {
                    vm.deleteAll()
                }
                .foregroundStyle(.red)
            }
            .padding(.bottom)
        }
        
    }
}

