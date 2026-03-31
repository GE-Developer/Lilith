//
//  CustomButtonRow.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CustomButtonRow: View {
    private let icon: Image?
    private let title: String
    private let subtitle: String?
    private let additionalTitle: String?
    private let isLink: Bool
    private let withCheckmark: Bool
    private let isCritical: Bool
    
    private let action: () -> Void
    
    init(icon: Image? = nil,
         title: String,
         subtitle: String? = nil,
         isLink: Bool = true,
         additionalTitle: String? = nil,
         withCheckmark: Bool = false,
         isCritical: Bool = false,
         action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.isLink = isLink
        self.additionalTitle = additionalTitle
        self.withCheckmark = withCheckmark
        self.isCritical = isCritical
        self.action = action
    }
    
    var body: some View {
        customButtonRow
    }
}

// MARK: - Builder
extension CustomButtonRow {
    var customButtonRow: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                iconPlace
                titlePlace
                Spacer()
                additionalPlace
                linkPlace
                checkmarkPlace
            }
            .padding(.vertical, subtitle == nil ? 16 : 6)
        }
        .disabled(withCheckmark)
    }
    
    private var iconPlace: some View {
        Group {
            if let icon {
                icon
                    .foregroundStyle(Gradient.heartGradient)
                    .frame(width: 50)
            } else {
                Spacer().frame(width: 20)
            }
        }
    }
    
    private var titlePlace: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .foregroundColor(Color.main.titleText)
                .font(.headline)
                .fontWeight(isCritical ? .semibold : .regular)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            if let subtitle {
                Text(subtitle)
                    .foregroundColor(Color.main.titleText)
                    .font(.caption)
                    .fontWeight(.ultraLight)
            }
        }
        .fontDesign(.rounded)
        .opacity(withCheckmark ? 0.5 : 1)
        .multilineTextAlignment(.leading)
        .padding(.trailing)
    }
    
    private var additionalPlace: some View {
        Group {
            if let additionalTitle {
                Text(additionalTitle)
                    .foregroundColor(Color.main.titleText)
                    .font(.headline)
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
                    .padding(.trailing)
            }
        }
    }
    
    private var linkPlace: some View {
        Group {
            if isLink {
                Image.system.chevron
                    .foregroundColor(Color.main.titleText)
                    .font(.footnote)
                    .padding(.trailing)
            }
        }
    }
    
    private var checkmarkPlace: some View {
        Group {
            if withCheckmark {
                Image.system.chechmark
                    .foregroundColor(Color.navigation.title)
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .padding(.trailing)
            }
        }
    }
}
