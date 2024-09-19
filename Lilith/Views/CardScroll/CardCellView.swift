//
//  CardCellView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 01.09.24.
//

import SwiftUI

struct CardCellView: View {

    @ObservedObject var vm: CardCellViewModel
    @State private var offset: CGFloat = 0
    
    private var imageSize: CGSize {
        CGSize(width: cellHeight * 0.6, height: cellHeight)
    }
    
    let threshold: CGFloat = 100
    let cellHeight: Double
    
    init(vm: CardCellViewModel, cellHeight: Double) {
        self.vm = vm
        self.cellHeight = cellHeight
        
//        print("\(vm.title) --- \(vm.romanNumber)")
    }
    
    
    var body: some View {
        HStack {
            CardImage(imageName: vm.imageName, cellHeight: cellHeight, imageSize: imageSize)
            VStack {
                Text(vm.title)
                    .font(
                        .system(.subheadline, design: .rounded)
                        .weight(.semibold)
                    )
                    .foregroundStyle(Color.main.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 5)
                ZStack {
                    RoundedRectangle(cornerRadius: cellHeight / 10)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.clear, Color.main.cell],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .shadow(color: Color.main.zodiacShadow, radius: 3)
                    HStack(spacing: 0) {
                        if let elementCard = vm.element {
                            VStack {
                                ElementView(element: elementCard, stroke: 2)
                                    .frame(width: cellHeight / 4.5, height: cellHeight / 4.5)
                                DescriptionText(text: elementCard.rawValue, cellHeight: cellHeight)
                            }
                            .frame(width: cellHeight / 1.6)
                        } else {
                            Spacer()
                                .frame(width: cellHeight / 1.6)
                        }
                        if let astrologyCard = vm.planet {
                            VStack {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .fill(.orange)
                                    .shadow(color: Color.main.zodiacShadow, radius: 5)
                                    .frame(height: cellHeight / 4.5)
                                    
                                DescriptionText(text: astrologyCard.rawValue, cellHeight: cellHeight)
                            }
                            .frame(width: cellHeight / 1.6)
                        }
                        if let zodiac = vm.zodiac {
                            VStack {
                                ZodiacView(
                                    zodiac: zodiac,
                                    size: cellHeight / 4.5
                                )
                                .frame(width: cellHeight / 1.6)
                                DescriptionText(text: zodiac.rawValue, cellHeight: cellHeight)
                            }
                        }
                        Spacer()
                        Text(vm.romanNumber)
                            .font(
                                .system(
                                    size: cellHeight / 6,
                                    weight: .semibold,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.white)
                            .padding(.trailing)
                    }
                }
            }
            .padding(.leading, 4)
        }
        .frame(height: cellHeight)
//        .offset(x: offset)
//        .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    if gesture.translation.width < 0 {
//                        offset = gesture.translation.width
//                    }
//                }
//                .onEnded { _ in
//                    withAnimation(.easeOut(duration: 0.2)) {
//                        if offset < -threshold {
//                            vm.isLiked = true
//                        }
//                        offset = 0 // Важно сбросить offset, чтобы избежать ошибок
//                    }
//                }
//        )
        
    }
}

struct CardImage: View {
    let imageName: String
    let cellHeight: Double
    let imageSize: CGSize
  
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
            Color.black.opacity(0)
        }
        .frame(width: imageSize.width, height: imageSize.height)
        .clipShape(
            RoundedRectangle(cornerRadius: cellHeight / 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cellHeight / 10)
                .stroke(Color.main.background, lineWidth: 1)
        )
        .shadow(color: Color.main.zodiacShadow, radius: 3)
    }
}




struct DescriptionText: View {
    let text: String
    let cellHeight: Double
    var body: some View {
        Text(text.uppercased())
            .font(.system(size: cellHeight / 15, weight: .medium, design: .rounded))
            .foregroundStyle(Color.main.title)
    }
}


// MARK: - Preview
//#Preview {
//    CardScrollView()
//        .preferredColorScheme(.light)
//}
