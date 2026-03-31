//
//  DeckInfoView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct DeckInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isCardAnimating = false

    private let vm: DeckInfoViewModel
    private let headerHeight: Double = 200

    init(deck: Deck, cardImageUrls: [String]) {
        vm = DeckInfoViewModel(deck: deck, cardImageUrls: cardImageUrls)
    }

    var body: some View {
        CustomScrollView(withBackButton: false, headerHight: headerHeight, type: .withLargeHeaderView) { isLarge in
            Image.system.xmark
                .opacity(0)
                .frame(width: 30, height: 30)
            Spacer()
            CustomNavigationBar(title: vm.title, subTitle: vm.subTitle, isLarge: isLarge, alignment: .center)
            Spacer()
            Button {
                dismiss()
            } label: {
                Image.system.xmark
                    .foregroundStyle(Color.navigation.cancelButton)
                    .frame(width: 30, height: 30)
            }
        } headerView: { minY in
            imageView
                .scaleEffect(min(max(1 + minY / headerHeight, 0), 1))
                .offset(y: min(minY / 2, 0))
                .opacity(
                    minY < -headerHeight / 2
                    ? max((minY + headerHeight) / 100.0, 0)
                    : 1
                )
        } scrollView: {
            descriptionText
        }
    }

    private var imageView: some View {
        ZStack {
            let centerIndex = vm.randomImageUrls.count / 2

            ForEach(0..<vm.randomImageUrls.count, id: \.self) { index in
                CustomAsyncImage(imageUrl: vm.randomImageUrls[index], 3/5, .fit)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.main.background, lineWidth: 1)
                    )
                    .shadow(color: Color.main.viewShadow, radius: 3)
                    .rotationEffect(.degrees(isCardAnimating ? Double(index - centerIndex) * 20 : 0), anchor: .bottom)
                    .offset(x: isCardAnimating ? CGFloat(index - centerIndex) * 25 : 0)
                    .animation(.bouncy(duration: 0.8).delay(0.3), value: isCardAnimating)
            }
        }
        .padding(.vertical, 30)
        .onAppear {
            isCardAnimating = true
        }
    }

    private var descriptionText: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !vm.mainDescription.isEmpty {
                Text(vm.mainDescription.asAttributedString())
                    .font(.body)
            }

            ForEach(vm.sections, id: \.title) { section in
                Divider()
                    .padding(.bottom)
                Text((section.title ?? "").asAttributedString())
                    .font(.title3)
                    .foregroundStyle(Color.navigation.title)
                ForEach(section.descriptions ?? [], id: \.self) { description in
                    HStack(alignment: .top) {
                        Text("•")
                            .fontWeight(.bold)
                        Text(description.asAttributedString())
                            .font(.callout)
                    }
                }
            }
        }
        .padding(.bottom)
        .lineSpacing(5)
        .fontWeight(.thin)
        .fontDesign(.rounded)
        .opacity(isCardAnimating ? 1 : 0)
        .animation(.bouncy.delay(0.1), value: isCardAnimating)
    }
}
