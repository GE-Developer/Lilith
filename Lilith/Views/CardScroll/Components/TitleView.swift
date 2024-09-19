//
//  TitleView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Custom Navigation Title
struct TitleView: View {
    
    /// View Properties
    let title: String
    
    @Binding var isSmall: Bool
    
    /// Body
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { print("Кнопка назад") }) {
                    Image(systemName: "chevron.left")
                        .animation(.easeOut, value: isSmall)
                        .fontWeight(.light)
                        .padding(.trailing, 10)
                        .foregroundStyle(Color.main.title)
                }
                VStack(alignment: .leading) {
                    //                Spacer()
                    Text(title)
                        .font(
                            .system(isSmall ? .title3 : .title, design: .rounded)
                            .bold()
                        )
                        .foregroundStyle(Color.main.title)
                    Text("Райдер Уэйт - Классика")
                        .font(
                            .system(.subheadline, design: .rounded)
                            .weight(.medium)
                        )
                        .foregroundStyle(Color.gray)
                }
                .animation(.easeOut, value: isSmall)
                
                Spacer()
                
                Button(action: { print("Переход на страницу лайков") }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(Color.main.background)
                            .shadow(color: Color.main.zodiacShadow, radius: 5)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(
                                RadialGradient(
                                    colors: [Color.main.red.opacity(0.7), Color.main.cell],
                                    center: .bottomTrailing,
                                    startRadius: 0,
                                    endRadius: 90
                                )
                            )
                            .offset(y: 2)
                            .scaleEffect(0.5)
                    }
                }
                .frame(height: isSmall ? 50 : 60)
                .animation(.easeInOut, value: isSmall)
                .rotation3DEffect(Angle(degrees: isSmall ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(.easeInOut(duration: 0.7), value: isSmall)
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    CardScrollView()
        .preferredColorScheme(.light)
}
