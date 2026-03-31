//
//  SettingsView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SettingsView: View {
    @State var vm = SettingsViewModel()
    @State private var showLanguage = false
    @State private var showDeveloper = false

    init() {
        UIScrollView.appearance().delaysContentTouches = false
    }

    var body: some View {
        settingsView
            .navigationDestination(isPresented: $showLanguage) {
                NavigationLazyView(LanguageView())
            }
            .navigationDestination(isPresented: $showDeveloper) {
                NavigationLazyView(DeveloperView())
            }
    }
}

// BUILDER
extension SettingsView {
    
    private var settingsView: some View {
        CustomScrollView { isLarge in
            CustomNavigationBar(title: vm.title, isLarge: isLarge)
            Spacer()
        } scrollView: {
            VStack(spacing: 25) {
                CustomForm(headerText: vm.generalSettingsTitle) {
                    themeToggle
                    Divider().padding(.leading, 50)
                    languageButton
                    Divider().padding(.leading, 50)
                    vibrationToggle
                    Divider().padding(.leading, 50)
                    soundToggle
                    Divider().padding(.leading, 50)
                    notificationToggle
                }
                
                CustomForm(headerText: vm.subscriptionAndAccessTitle) {
                    subscriptionStatus
                } content: {
                    subscriptionButton
                    Divider().padding(.leading, 50)
                    purchasesButton
                    Divider().padding(.leading, 50)
                    reviewButton
                }
                
                CustomForm(headerText: vm.memoryTitle) {
                    deleteCacheButton
                    Divider().padding(.leading, 50)
                    deleteHistoryButton
                    Divider().padding(.leading, 50)
                    resetButton
                }
                
                CustomForm(headerText: vm.customizationTitle) {
                    appIconButton
                    Divider().padding(.leading, 50)
                    musicButton
                }
                
                CustomForm(headerText: vm.aboutAppTitle) {
                    termsOfUseButton
                    Divider().padding(.leading, 50)
                    privacyPolicyButton
                    Divider().padding(.leading, 50)
                    developersButton
                }
                
                appVersionView
            }
        }
    }
    
    private var themeToggle: some View {
        CustomToggleRow(
            isOff: $vm.isThemeLight,
            icon: .system.darkMode,
            title: vm.darkModeTitle
        )
    }
    
    private var languageButton: some View {
        CustomButtonRow(
            icon: Image.system.language,
            title: vm.languageTitle,
            subtitle: L10n("UI.Settings.languageSubtitle"),
            isLink: true,
            additionalTitle: vm.language
        ) {
            showLanguage = true
        }
    }
    
    private var vibrationToggle: some View {
        CustomToggleRow(
            isOff: $vm.isHapticsOff,
            icon: .system.vibration,
            title: vm.vibrationTitle
        )
    }
    
    private var soundToggle: some View {
        CustomToggleRow(
            isOff: $vm.isSoundOff,
            icon: .system.sound,
            title: vm.soundTitle
        )
    }
    
    private var notificationToggle: some View {
        CustomToggleRow(
            isOff: .constant(true),
            icon: .system.notifications,
            title: vm.notificationsTitle
        )
    }
    
    private var subscriptionStatus: some View {
        SubscriptionStatusBadge(
            isPremium: vm.access,
            premiumTitle: vm.premiumBannerTitle,
            basicTitle: vm.basicBannerTitle
        )
    }
    
    private var subscriptionButton: some View {
        CustomButtonRow(
            icon: .system.subscription,
            title: vm.subscriptionTitle
        ) {}
    }
    
    private var purchasesButton: some View {
        CustomButtonRow(
            icon: .system.restorePurchases,
            title: vm.restorePurchasesTitle,
            isLink: false
        ) {}
    }
    
    private var reviewButton: some View {
        CustomButtonRow(
            icon: .system.reviewLike,
            title: vm.reviewTitle,
            isLink: false
        ) {}
    }
    
    private var deleteCacheButton: some View {
        CustomButtonRow(
            icon: .system.binFill,
            title: vm.clearCacheTitle,
            isLink: false,
            action: vm.clearCache
        )
    }
    
    private var deleteHistoryButton: some View {
        CustomButtonRow(
            icon: .system.clearHistory,
            title: vm.clearHistoryTitle,
            isLink: false
        ) {}
    }
    
    private var resetButton: some View {
        CustomButtonRow(
            icon: .system.resetAllSettings,
            title: vm.resetAllTitle,
            isLink: false,
            isCritical: true,
            action: vm.resetData
        )
    }
    
    private var appIconButton: some View {
        CustomButtonRow(
            icon: .system.rectangle,
            title: vm.appIconTitle
        ) {}
    }
    
    private var musicButton: some View {
        CustomButtonRow(
            icon: .system.music,
            title: vm.backgroundMusicTitle
        ) {}
    }
    
    private var termsOfUseButton: some View {
        CustomButtonRow(
            icon: .system.termsOfUse,
            title: vm.termsOfUseTitle,
            isLink: false
        ) {}
    }
    
    private var privacyPolicyButton: some View {
        CustomButtonRow(
            icon: .system.privacyPolicy,
            title: vm.privacyPolicyTitle,
            isLink: false
        ) {}
    }
    
    private var developersButton: some View {
        CustomButtonRow(
            icon: .system.developerTool,
            title: vm.developersTitle
        ) {}
    }
    
    private var appVersionView: some View {
        VStack {
            Text(L10n("UI.Settings.appVersion"))
            Text(vm.appVersion)
        }
        .foregroundStyle(Color.main.secondaryText)
        .font(.caption)
        .fontDesign(.monospaced)
        .padding(.horizontal, 6)
        .onTapGesture(count: 1) {
            SoundManager.shared.playSound()
            showDeveloper = true
        }
    }
}
