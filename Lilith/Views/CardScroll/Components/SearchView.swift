//
//  SearchView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.09.24.
//

import SwiftUI

// MARK: - Custom Search View
struct SearchView: View {

    
    /// View Properties
    @Binding var searchText: String
    @FocusState var isInputActive: Bool
    let minY: Double
    
    @Binding var isHidden: Bool
    
    let placeholderText: String
    
    /// Body
    var body: some View {

            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .fontWeight(.ultraLight)
                    .padding(.leading, 10)
                //                .foregroundStyle(
                //                    searchText.isEmpty
                //                    ? Color("")
                //                    : Color("")
                //                )
                    .opacity(1 + (minY / 20))
                    .foregroundStyle(isInputActive ? Color.black : Color.gray)
                    .animation(.easeOut, value: isInputActive)
                
                TextField(placeholderText, text: $searchText)
                    .focused($isInputActive)
                    .keyboardType(.default)
                    .autocorrectionDisabled(true)
                    .padding(10)
                //                .frame(height: 45)
                    .onTapGesture { isInputActive = true }
                    .opacity(1 + (minY / 20))
                    .foregroundStyle(Color.main.secondaryText)
                    .fontDesign(.rounded)
                    .fontWeight(.light)
                
                if !searchText.isEmpty {
                    Button(action: { searchText = ""} ) {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.ultraLight)
                            .foregroundStyle(.black)
                            .padding(.trailing, 10)
                    }
                    .opacity(1 + (minY / 20))
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.main.background)
                    .shadow(color: Color.main.zodiacShadow, radius: 4)
                    .frame(height: minY < 0 ? max(40 + Double(minY), 0) : 40)
            }
            .onScrollVisibilityChange { isOnScreen in
                isHidden = !isOnScreen
                if isHidden {
                    isInputActive = false
                }
                print(isOnScreen)
            }
            

    }
}

#Preview {
    CardScrollView()
        .preferredColorScheme(.light)
}
