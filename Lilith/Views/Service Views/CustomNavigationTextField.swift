//
//  CustomNavigationTextField.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CustomNavigationTextField: View {
    @Binding var text: String
    
    @FocusState private var focus: Bool
    @State private var isButtonEnabled = false
    
    private let minY: Double
    private let image: Image
    private let placeholder: String
    private let cancelButtonTitle: String
    
    private let deleteAction: () -> Void
    
    init(text: Binding<String>,
         isButtonEnabled: Bool = false,
         minY: Double,
         image: Image,
         placeholder: String,
         cancelButtonTitle: String,
         deleteAction: @escaping () -> Void) {
        _text = text
        self.isButtonEnabled = isButtonEnabled
        self.minY = minY
        self.image = image
        self.placeholder = placeholder
        self.cancelButtonTitle = cancelButtonTitle
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        customNavigationTextField
    }
}

// MARK: - Builder
extension CustomNavigationTextField {
    private var customNavigationTextField: some View {
        HStack {
            HStack(spacing: 0) {
                searchImage
                searchField
                deleteButton
            }
            .opacity(max(1.0 + (minY / 20), 0))
            .background { background }
            .onTapGesture { focus = true }
            
            if isButtonEnabled {
                cancelButton
            }
        }
        .animation(.easeInOut, value: isButtonEnabled)
        .animation(.easeInOut, value: focus)
    }
    
    private var searchImage: some View {
        image
            .font(.title3)
            .fontWeight(.ultraLight)
            .padding(.leading, 10)
            .foregroundStyle(
                focus ? Color.navigation.focusedMagnifying : Color.navigation.magnifying
            )
    }
    
    private var searchField: some View {
        TextField(placeholder, text: $text) { isEditing in
            isButtonEnabled = isEditing
        }
        .focused($focus)
        .autocorrectionDisabled(true)
        .padding(10)
        .foregroundStyle(Color.main.textFieldText)
        .fontDesign(.rounded)
        .fontWeight(.light)
    }
    
    private var deleteButton: some View {
        Button(action: deleteAction) {
            Image.system.xmark
                .font(.title3)
                .fontWeight(.ultraLight)
                .foregroundStyle(Color.navigation.cancelButton)
                .padding(.trailing, 10)
        }
        .opacity(text.isEmpty ? 0 : 1)
        .animation(.default, value: text)
    }
    
    private var cancelButton: some View {
        Button(action: { focus = false }) {
            Text(cancelButtonTitle)
                .foregroundStyle(Color.navigation.cancelButton)
                .fontDesign(.rounded)
                .fontWeight(.thin)
        }
        .transition(.move(edge: .trailing).combined(with: .opacity))
        .opacity(1 + (minY / 20))
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.navigation.textFieldBackground)
            .shadow(color: Color.main.viewShadow, radius: 4)
            .frame(height: minY < 0 ? max(40 + Double(minY), 0) : 40)
    }
}
