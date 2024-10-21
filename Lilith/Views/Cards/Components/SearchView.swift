//
//  SearchView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var vm: CardsViewModel
    @FocusState var focus: Bool
    @State private var isButtonEnabled = false

    let minY: Double
    
    var body: some View {
        HStack {
            HStack(spacing: 0) {
                searchImage
                searchField
                deleteButton
            }
            .opacity(max(1 + (minY / 20), 0))
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
        Image.system.magnifyingglass
            .font(.title3)
            .fontWeight(.ultraLight)
            .padding(.leading, 10)
            .foregroundStyle(
                focus ? Color.navigation.focusedMagnifying : Color.navigation.magnifying
            )
    }
    
    private var searchField: some View {
        TextField(vm.placeholderText, text: $vm.searchText) { isEditing in
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
        Button(action: vm.deleteText) {
            Image.system.xmark
                .font(.title3)
                .fontWeight(.ultraLight)
                .foregroundStyle(Color.navigation.cancelButton)
                .padding(.trailing, 10)
        }
        .opacity(vm.searchText.isEmpty ? 0 : 1)
        .animation(.default, value: vm.searchText)
    }
    
    private var cancelButton: some View {
        Button(action: { focus = false }) {
            Text(vm.cancelButtonTitle)
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
