//
//  LanguageView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct LanguageView: View {
    @State private var vm = LanguageViewModel()
    @State private var isShowingAlert = false

    var body: some View {
        CustomScrollView { isLarge in
            CustomNavigationBar(title: vm.title, isLarge: isLarge)
            Spacer()
        } scrollView: {
            CustomForm {
                ForEach(Array(AppLanguage.allCases.enumerated()), id: \.element.id) { index, language in
                    VStack(spacing: 0) {
                        CustomButtonRow(
                            title: language.localizedName,
                            subtitle: language.englishName,
                            isLink: false,
                            withCheckmark: vm.isWithCheckmark(language),
                            action: {
                                vm.tappedLanguage = language
                                isShowingAlert.toggle()
                            }
                        )
                        if index < AppLanguage.allCases.count - 1 {
                            Divider()
                                .padding(.leading, 20)
                        }
                    }
                }
            }
            .alert(
                Text(vm.alertTitle),
                isPresented: $isShowingAlert,
                actions: {
                    Button(vm.alertActionTitle, role: .destructive) {
                        vm.setNewLanguage()
                    }
                    Button(vm.alertCancelTitle, role: .cancel) {}
                },
                message: {
                    Text(vm.alertMessage)
                }
            )
        }
    }
}
