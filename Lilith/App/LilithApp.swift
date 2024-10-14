//
//  LilithApp.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 26.08.24.
//

import SwiftUI

@main
struct LilithApp: App {
    @State private var isDark = true
    var body: some Scene {
        WindowGroup {
            NavigationStack {
           
                VStack {
                    NavigationLink {
                        CardsView(ClassicCard())
                    } label: {
                        Text("Райдер Уэйт")
                            .font(.title3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                    }
                    Divider()
                    NavigationLink {
                        CardsView(OtherCard())
                    } label: {
                        Text("Тестовая Колода")
                            .font(.title3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                    }
                    Divider()
                    Toggle("Сменить тему", isOn: $isDark)
                    Divider()
                    Button("Удалить базу") {
                        StorageManager.shared.deleteAll { _ in }
                    }
                }
                .padding()
            }
            .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}
