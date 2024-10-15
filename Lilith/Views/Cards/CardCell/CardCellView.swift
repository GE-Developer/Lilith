//
//  CardCellView.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 13.10.24.
//

import SwiftUI

struct Cell: View {
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
                HStack {
                    Circle()
                        .stroke(lineWidth: 2)
                        .fill(Color.sign.planet)
                        .shadow(color: Color.sign.shadow, radius: 5)
                        .frame(height: cellHeight / 14)
                    
                    Text(planet.name.uppercased())
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
    }
    
    private var zodiacView: some View {
        Group {
            if let zodiac = vm.zodiac {
                HStack {
                    ZodiacView(zodiac: zodiac, size: cellHeight / 14)
                    
                    Text(zodiac.name.uppercased())
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
    }
    
    private var elementView: some View {
        Group {
            if let element = vm.element {
                HStack {
                    ElementView(element: element, stroke: 1)
                        .frame(width: cellHeight / 14, height: cellHeight / 14)
                    Text(element.name.uppercased())
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
