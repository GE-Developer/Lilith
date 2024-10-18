//
//  LilithApp.swift
//  Lilith
//
//  Created by GE-Developer
//  26.08.2024

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
                    Toggle("Сменить тему", isOn: $isDark)
                    Divider()
                    Button("Удалить базу") {
                        StorageManager.shared.deleteAll { _ in }
                    }
                    Divider()
                    LanguagePickerView()

                }
                .padding()
            }
            .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}



struct Language: Identifiable {
    let id: String
    let displayName: String
}

struct LanguagePickerView: View {
    @State private var selectedLanguage: String = "en" // Значение по умолчанию
    
    let supportedLanguages: [Language] = [
        Language(id: "en", displayName: "English"),
        Language(id: "ru", displayName: "Русский"),
        Language(id: "ka", displayName: "ქართული")
    ]

    var body: some View {
        HStack {
            Picker("Select Language", selection: $selectedLanguage) {
                ForEach(supportedLanguages) { language in
                    Text(language.displayName).tag(language.id)
                }
            }
            .pickerStyle(MenuPickerStyle())

            Button("Сменить язык") {
                UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                
                exit(0)
            }
        }
    }
}
