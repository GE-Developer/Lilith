//
//  CardCellView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 01.09.24.
//

import SwiftUI

struct CardCellView: View {
    
    @ObservedObject var vm: CardCellViewModel
    
    let cellHeight: Double
    
    @State private var offset = 0.0
    
    @State private var isGestureEnabled = true
    
    var body: some View {
        GeometryReader { geometry in
            let geometryWidth = geometry.size.width
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Gradient.cellGradient)
                HStack(alignment: .top) {
                    imageView
                    
                    VStack(alignment: .leading) {
                        HStack {
                            titleTextView
                            Spacer()
                            romanView
                        }
                        Divider()
                        
                        VStack(alignment: .leading) {
                            planetView
                            zodiacView
                            elementView
                        }
                    }
                    .padding(8)
                }
                .padding(8)
                
                likeSymbolView
                
                gestureZone
                    .offset(x: geometryWidth - cellHeight / 2.5)
                    .gesture(gest)
                
                likeAndDeleteSwipeView
                    .offset(x: geometryWidth + 16 - offset / 2.25 - cellHeight / 7)
            }
            .offset(x: offset)
        }
        .frame(maxWidth: .infinity)
        .frame(height: cellHeight)
        .allowsHitTesting(isGestureEnabled)
        .onAppear {
            vm.isLikeButtonShow = !vm.isLiked
        }
    }
    
    private var imageView: some View {
        Image("Тест1")
            .resizable()
            .scaledToFit()
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.main.background, lineWidth: 1)
            )
            .shadow(color: Color.main.viewShadow, radius: 3)
    }

    private var titleTextView: some View {
        Text(vm.title)
            .foregroundStyle(Color.main.text)
            .font(.subheadline)
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .multilineTextAlignment(.leading)
    }
    
    private var romanView: some View {
        Group {
            if vm.romanNumber != "" {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 40, height: 20)
                        .foregroundStyle(Color.navigation.romanBackground)
                        .shadow(color: Color.sign.shadow, radius: 1)
                    
                    Text(vm.romanNumber)
                        .foregroundStyle(Color.sign.romanText)
                        .font(.caption)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(.vertical, 3)
                }
            }
        }
    }
    
    private var planetView: some View {
        Group {
            if let planet = vm.planet {
                HStack {
                    Circle()
                        .stroke(lineWidth: 2)
                        .fill(Color.sign.planet)
                        .shadow(color: Color.sign.shadow, radius: 5)
                        .frame(height: cellHeight / 10)
                    
                    Text(planet.rawValue.uppercased())
                        .foregroundStyle(Color.main.secondaryText)
                        .font(.caption)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                }
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color.main.background)
                }
            }
        }
    }
    
    private var zodiacView: some View {
        Group {
            if let zodiac = vm.zodiac {
                HStack {
                    ZodiacView(zodiac: zodiac, size: cellHeight / 10)
                    
                    Text(zodiac.rawValue.uppercased())
                        .foregroundStyle(Color.main.secondaryText)
                        .font(.caption)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                }
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color.main.background)
                }
            }
        }
    }
    
    private var elementView: some View {
        Group {
            if let element = vm.element {
                HStack {
                    ElementView(element: element, stroke: 2)
                        .frame(width: cellHeight / 10, height: cellHeight / 10)
                    Text(element.rawValue.uppercased())
                        .foregroundStyle(Color.main.secondaryText)
                        .font(.caption)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                }
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color.main.background)
                }
            }
        }
    }
    
    private var gestureZone: some View {
        Circle()
            .frame(height: cellHeight / 2.5)
            .foregroundStyle(.clear)
            .contentShape(Circle())
    }
    
    private var likeAndDeleteSwipeView: some View {
        Group {
            if vm.isLikeButtonShow {
                FabulaLikeButton(
                    isSelected: vm.isLiked,
                    image: Image.system.heart,
                    imageFill: Image.system.heartFill
                )
            } else {
                FabulaLikeButton(
                    isSelected: !vm.isLiked,
                    image: Image(systemName: "xmark.bin"),
                    imageFill: Image(systemName: "xmark.bin.fill")
                )
            }
        }
        .frame(width: cellHeight / 4.5 ,height: cellHeight / 4.5)
        .scaleEffect(max(min(0.1 - offset / 100, 1), 0))
        .opacity(max(min(0 - offset / 100, 1), 0))
    }
    
    private var likeSymbolView: some View {
        Group {
            
        }
    }
    
    private var gest: some Gesture {
        
        
        
        
        
        
        
        
        DragGesture(minimumDistance: 20, coordinateSpace: .global)
        
            .onChanged { gesture in
                withAnimation {
                    let xGesture = gesture.translation.width
                    let xOffset = max(xGesture, -70) + xGesture / 5
                    offset = max(min(xOffset, 0), -105)
                }
            }
        
            .onEnded { _ in
                if offset < -100 {
                    isGestureEnabled = false
                    if vm.isLiked {
                        vm.delete()
                        print("(if) = Было лайкнуто - сменилось на = \(vm.isLiked)")
                        print("(if) = Состояние кнопки = \(vm.isLikeButtonShow)")
                    } else {
                        vm.create()
                        print("(else) = Не было лайкнуто - сменилось на = \(vm.isLiked)")
                        print("(else) = Состояние кнопки = \(vm.isLikeButtonShow)")
                    }
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 13)) {
                        offset = -110
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 13)) {
                            offset = 0
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 13)) {
                            vm.isLikeButtonShow = !vm.isLiked
                            print("(Через 2.5 сек) = Состояние кнопки = \(vm.isLikeButtonShow)")
                        }
                        isGestureEnabled = true
                    }
                    
                } else {
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 13)) {
                        offset = 0
                    }
                }
            }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
