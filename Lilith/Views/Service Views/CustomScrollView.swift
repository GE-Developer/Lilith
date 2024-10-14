//
//  CustomScrollView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 24.09.24.
//

import SwiftUI

struct CustomScrollView<Header: View, Scroll: View, Title: View>: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var minY = 0.0
    
    private var scrollBehavior: CustomScrollTargetBehaviourForScrollView {
        CustomScrollTargetBehaviourForScrollView(
            type: type,
            minY: minY,
            headerHeight: headerHeight,
            largeNavBarHeight: largeNavBarHeight,
            smallNavBarHeight: smallNavBarHeight
        )
    }
    private var isLarge: Bool {
        switch type {
        case .withEmptyHeaderView:
            -minY < 8
        case .withSearchField:
            -minY < headerHeight / 2 + 8
        case .withLargeHeaderView:
            -minY < headerHeight + 8 + largeNavBarHeight - smallNavBarHeight
        }
    }
    private var contentMargin: Double {
        max(headerHeight + 10 + minY, smallNavBarHeight - headerHeight + 10)
    }
    
    private let headerHeight: Double
    private let withBackButton: Bool
    private let type: ViewType
    
    private let largeNavBarHeight = 70.0
    private let smallNavBarHeight = 50.0
    
    @ViewBuilder let titleHStackView: (_ isLarge: Bool) -> Title
    @ViewBuilder let headerView: (_ minY: CGFloat) -> Header
    @ViewBuilder let scrollView: () -> Scroll
    
    init(withBackButton: Bool = true,
         headerHight: Double = 0,
         type: ViewType = .withEmptyHeaderView,
         @ViewBuilder titleHStackView: @escaping (_ isLarge: Bool) -> Title,
         @ViewBuilder headerView: @escaping (_ minY: CGFloat) -> Header = { _ in EmptyView() },
         @ViewBuilder scrollView: @escaping () -> Scroll) {
        self.titleHStackView = titleHStackView
        self.headerView = headerView
        self.type = type
        self.scrollView = scrollView
        self.withBackButton = withBackButton
        self.headerHeight = headerHight
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.main.background
                .ignoresSafeArea()
                .zIndex(0)
            
            scrollTitleView
                .zIndex(2)
            
            ScrollView {
                scrollHeaderView
                scrollView()
            }
            .scrollDismissesKeyboard(.immediately)
            .safeAreaPadding(.horizontal)
            .safeAreaPadding(.top, largeNavBarHeight + 8)
            .scrollTargetBehavior(scrollBehavior)
            .contentMargins(.top, contentMargin, for: .scrollIndicators)
            .zIndex(1)
            
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private var scrollTitleView: some View {
        ZStack {
            UnevenRoundedRectangle(
                bottomLeadingRadius: isLarge ? 0 : 10,
                bottomTrailingRadius: isLarge ? 0 : 10
            )
            .ignoresSafeArea()
            .foregroundStyle(Color.main.background)
            .opacity(isLarge ? 1 : 0.98)
            .shadow(color: Color.navigation.navBarShadow, radius: isLarge ? 0 : 5)
            
            HStack {
                if withBackButton {
                    backButton
                }
                titleHStackView(isLarge)
            }
            .padding(.horizontal)
        }
        .frame(height: isLarge ? largeNavBarHeight : smallNavBarHeight)
        .animation(.easeOut, value: isLarge)
    }
    
    private var scrollHeaderView: some View {
        GeometryReader { proxy in
            let localMinY = proxy.frame(in: .scrollView).minY
            
            headerView(localMinY)
                .preference(key: MinYPreferenceKey.self, value: localMinY)
                .offset(y: min(-localMinY, 0))
        }
        .onPreferenceChange(MinYPreferenceKey.self) { newValue in
            self.minY = newValue
        }
        .frame(height: headerHeight)
        .padding(.bottom, 8)
    }
    
    private var backButton: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .fontWeight(.light)
                .padding(.trailing, 8)
                .foregroundStyle(Color.navigation.backButton)
        }
    }
}

// MARK: - Preference Key
#warning("Проверить: PreferenceKey")
struct MinYPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Enum
enum ViewType {
    case withSearchField
    case withLargeHeaderView
    case withEmptyHeaderView
}

// MARK: - Scroll Behavior
struct CustomScrollTargetBehaviourForScrollView: ScrollTargetBehavior {
    let type: ViewType
    let minY: Double
    let headerHeight: Double
    let largeNavBarHeight: Double
    let smallNavBarHeight: Double
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let fullHeader = headerHeight + 8 + largeNavBarHeight - smallNavBarHeight
        let halfHeader = headerHeight / 2 + 8 + largeNavBarHeight - smallNavBarHeight
        let quarterHeader = headerHeight / 4 + 8
        
        switch type {
        case .withSearchField:
            switch target.rect.minY {
            case 0 ..< quarterHeader:
                target.rect.origin = .zero
            case quarterHeader ..< halfHeader:
                target.rect.origin = .init(x: 0, y: halfHeader)
            case halfHeader + 0.1 ..< fullHeader - headerHeight / 7:
                target.rect.origin = .init(x: 0, y: halfHeader)
            case fullHeader - headerHeight / 7 + 0.1 ..< fullHeader + 10:
                target.rect.origin = .init(x: 0, y: fullHeader + 10)
            default:
                break
            }
        case .withLargeHeaderView:
            switch target.rect.minY {
            case 0 ..< halfHeader:
                target.rect.origin = .zero
            case halfHeader ..< fullHeader:
                target.rect.origin = .init(x: 0, y: fullHeader)
            default:
                break
            }
        case .withEmptyHeaderView:
            switch target.rect.minY {
            case 0 ..< 8:
                target.rect.origin = .zero
            default:
                break
            }
        }
    }
}
