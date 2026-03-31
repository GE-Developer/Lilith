//
//  DeveloperView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

@MainActor
@Observable
final class DeveloperViewModel {
    var devAccess = false
    var typedText: String

    let devCode = "test"
    let title = L10n("UI.Developer.title")
    let placeHolder = L10n("UI.Developer.code")
    let cancelButton = L10n("UI.Developer.cancel")
    let noticeText = L10n("UI.Developer.notice")

    var premiumAccess: Bool {
        DeveloperManager.shared.isPremium
    }

    var isButtonEnabled: Bool {
        devAccess || !typedText.isEmpty
    }

    var premiumToggleIsOff: Bool {
        get {
            !DeveloperManager.shared.isPremium
        } set {
            DeveloperManager.shared.isPremium = !newValue
        }
    }

    var earlyAccessToggleIsOff: Bool {
        get {
            !DeveloperManager.shared.isEarlyAccess
        } set {
            DeveloperManager.shared.isEarlyAccess = !newValue
        }
    }

    var betaAccessToggleIsOff: Bool {
        get {
            !DeveloperManager.shared.isBetaFeaturesAccess
        } set {
            DeveloperManager.shared.isBetaFeaturesAccess = !newValue
        }
    }
    
    init() {
        typedText = ""
    }
    
    func clearTypedText() {
        typedText = ""
        HapticsManager.shared.impact(style: .rigid)
    }
    
    func lockButtonTapped() {
        switch devAccess {
        case true:
            devAccess = false
            typedText = ""
            HapticsManager.shared.notification(type: .success)
        case false:
            if devCode == typedText {
                devAccess = true
                HapticsManager.shared.notification(type: .success)
            } else {
                HapticsManager.shared.notification(type: .error)
            }
            typedText = ""
        }
    }
}

struct DeveloperView: View {
    @State private var vm = DeveloperViewModel()
    
    var body: some View {
        developerView
    }
}

extension DeveloperView {
    var developerView: some View {
        CustomScrollView(headerHight: 70, type: .withSearchField) { isLarge in
            CustomNavigationBar(title: vm.title, isLarge: isLarge)
            Spacer()
        } headerView: { minY in
            headerView(minY)
        } scrollView: {
            VStack(spacing: 25) {
                Text(vm.noticeText.asAttributedString())
                    .foregroundStyle(Color.main.secondaryText)
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.navigation.textFieldBackground)
                            .shadow(color: Color.main.viewShadow, radius: 4)
                    }
                
                if vm.devAccess {
                    VStack(spacing: 25) {
                        CustomForm(headerText: L10n("UI.Developer.subscriptionAndPurchases")) {
                            subscriptionStatus
                        } content: {
                            CustomToggleRow(
                                isOff: $vm.premiumToggleIsOff,
                                icon: .system.subscription,
                                title: L10n("UI.Developer.premium")
                            )
                        }

                        CustomForm(headerText: L10n("UI.Developer.fullAccess")) {
                            CustomToggleRow(
                                isOff: $vm.earlyAccessToggleIsOff,
                                icon: .system.earlyAccess,
                                title: L10n("UI.Developer.earlyAccess")
                            )
                            Divider().padding(.leading, 50)
                            CustomToggleRow(
                                isOff: $vm.betaAccessToggleIsOff,
                                icon: .system.betaFeatures,
                                title: L10n("UI.Developer.betaFeatures")
                            )
                        }
                    }
                }
                
                
            }
        }
    }
    
    private var subscriptionStatus: some View {
        SubscriptionStatusBadge(
            isPremium: vm.premiumAccess,
            premiumTitle: L10n("UI.Developer.premium"),
            basicTitle: L10n("UI.Developer.basic")
        )
    }
    
    @ViewBuilder
    private func headerView(_ minY: CGFloat) -> some View {
        HStack {
            Button(action: {
                withAnimation {
                    vm.lockButtonTapped()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }) {
                (vm.devAccess ? Image.system.lockOpen : Image.system.lockClosed)
                    .frame(width: 60)
                    .foregroundStyle(
                        vm.devAccess
                        ? Color.sign.earth
                        : Color.navigation.title
                    )
                    .opacity(max(1.0 + (minY / 20), 0))
                    .background{ background(minY) }
            }
            .disabled(!vm.isButtonEnabled)
            .opacity(vm.isButtonEnabled ? 1 : 0.6)
            .animation(.default, value: vm.isButtonEnabled)
            
            CustomNavigationTextField(
                text: $vm.typedText,
                minY: minY,
                image: .system.code,
                placeholder: vm.placeHolder,
                cancelButtonTitle: vm.cancelButton,
                deleteAction: vm.clearTypedText
            )
            .autocapitalization(.none)
        }
        .offset(y: min(minY / 2, 0))
    }
    
    @ViewBuilder
    private func background(_ minY: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.navigation.textFieldBackground)
            .shadow(color: Color.main.viewShadow, radius: 4)
            .frame(height: minY < 0 ? max(40 + Double(minY), 0) : 40)
    }

}
