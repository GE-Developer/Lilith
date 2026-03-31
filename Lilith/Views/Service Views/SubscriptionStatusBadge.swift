//
//  SubscriptionStatusBadge.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SubscriptionStatusBadge: View {
    let isPremium: Bool
    let premiumTitle: String
    let basicTitle: String

    var body: some View {
        HStack(alignment: .center) {
            if isPremium {
                Image.system.starFill
                    .foregroundStyle(Color(.secondarySystemGroupedBackground))
            }
            Text(isPremium ? premiumTitle : basicTitle)
                .foregroundStyle(Color.subscription.bannerText)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .textCase(.uppercase)
                .minimumScaleFactor(0.5)
        }
        .font(.caption2)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    isPremium
                    ? Gradient.premiumSubscriptionGradiaent
                    : Gradient.basicSubscriptionGradiaent
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.secondarySystemGroupedBackground), lineWidth: 2)
                )
        }
        .padding(.trailing, 6)
    }
}
