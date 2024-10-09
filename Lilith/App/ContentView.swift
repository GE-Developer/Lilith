//
//  ContentView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 24.09.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                CardsView()
            } label: {
                Text("Перейти CardsView")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
            }
            
            NavigationLink {
                NewSwiftDataView()
            } label: {
                Text("Перейти на CoreData")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
            }
        }
    }
}


