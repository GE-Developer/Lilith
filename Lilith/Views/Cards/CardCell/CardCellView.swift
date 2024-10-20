//
//  CardCellView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct CardCellView: View {
    @ObservedObject var vm: CardCellViewModel
    
    let cellHeight: Double
    
    var body: some View {
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
                    
                    VStack(alignment: .leading, spacing: 5) {
                        planetView
                        zodiacView
                        elementView
                    }
                }
                .padding(.top, 3)
                .padding(.horizontal, 3)
            }
            .padding(8)
            
            likeSymbolView
        }
    }
    
    private var imageView: some View {
        Image(vm.cardID)
            .resizable()
            .aspectRatio(3/5, contentMode: .fit)
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
            .lineLimit(2)
            .minimumScaleFactor(0.5)
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
                SpecializationView(title: planet.name, cellHeight: cellHeight) {
                    PlanetView(planet: planet, size: cellHeight / 12)
                }
            }
        }
    }
    
    private var zodiacView: some View {
        Group {
            if let zodiac = vm.zodiac {
                SpecializationView(title: zodiac.name, cellHeight: cellHeight) {
                    ZodiacView(zodiac: zodiac, size: cellHeight / 12)
                }
            }
        }
    }
    
    private var elementView: some View {
        Group {
            if let element = vm.element {
                SpecializationView(title: element.name, cellHeight: cellHeight) {
                    ElementView(element: element, stroke: 1)
                }
            }
        }
    }
    
    private var likeSymbolView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image.system.heartFill
                    .font(.title)
                    .foregroundStyle(Gradient.heartGradient)
                    .shadow(color: Color.main.background, radius: 3)
                    .opacity(vm.isLiked ? 1 : 0.001)
                    .scaleEffect(vm.isLiked ? 1 : 0.001)
                    .animation(.snappy(duration: 0.2).delay(0.8), value: vm.isLiked)
            }
        }
        .padding()
    }
}

fileprivate struct SpecializationView<ElementImage: View>: View {
    let title: String
    let cellHeight: Double
    
    @ViewBuilder let elementImage: () -> ElementImage
    
    var body: some View {
        HStack {
            elementImage()
                .frame(width: cellHeight / 12, height: cellHeight / 12)
            Text(title.uppercased())
                .foregroundStyle(Color.main.secondaryText)
                .font(.caption2)
                .fontWeight(.medium)
                .fontDesign(.rounded)
        }
        .padding(4)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.main.background)
        }
    }
}
