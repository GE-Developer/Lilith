import SwiftUI

struct HeartTextView: View {
    @State private var isSelected = false
    
    var body: some View {
        VStack {
            FabulaLikeButton(
                isSelected: isSelected,
                image: Image.system.heart,
                imageFill: Image.system.heartFill
            )
                .frame(width: 100, height: 100)
            Spacer()
            Button {
                isSelected.toggle()
            } label: {
                Text("GO")
                    .font(.largeTitle)
            }

        }
    }
}



struct FabulaLikeEffect: View {
    
    @Binding var scale: CGFloat
    var tickCount = 7
    var size: CGFloat = 3
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                ForEach(0..<tickCount, id: \.self) { tick in
                    Circle()
                        .scaleEffect(scale)
                        .animation(scale != 1 ? Animation.easeInOut(duration: 0.8) : Animation.easeInOut(duration: 0), value: scale)
                        .frame(width: size, height: size)
                        .offset(x: proxy.size.width <= proxy.size.height ? -(proxy.size.width / 2) : -(proxy.size.height / 2 ))
                        .rotationEffect(.degrees(Double(tick) / Double(tickCount)) * 360)
                        .offset(x: -size/2, y: -size/2)
                    
                }
            }
            .offset(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}

struct FabulaLikeButton: View {
    
    let isSelected: Bool
    let normalColor: Color = Color.white
    let selectColor: Color = Color.navigation.romanBackground
    let effectColor: Color = Color.navigation.heartTwo
    let image: Image
    let imageFill: Image
    
    @State private var scaleSmall: CGFloat = 0.0001
    @State private var scaleLarge: CGFloat = 0.0001
    @State private var scaleCircle: CGFloat = 0.0001
    
    var body: some View {
        GeometryReader{ proxy in
            let minSize = min(proxy.size.width, proxy.size.width)
            
            ZStack {
                image
                    .font(.system(size: minSize))
                    .fontWeight(.ultraLight)
                    .opacity(isSelected ? 0 : 1)
                    .scaleEffect(isSelected ? 0.0001 : 1)
                    .foregroundColor(normalColor)
                    .animation(isSelected ? Animation.easeOut(duration: 0) : Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.8), value: isSelected)
                
                imageFill
                    .font(.system(size: minSize))
                    .opacity(isSelected ? 1 : 0)
                    .scaleEffect(isSelected ? 1 : 0.0001)
                    .foregroundColor(isSelected ? selectColor : Color.clear)
                    .animation(isSelected ? Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.8).delay(0.2) : Animation.easeOut(duration: 0), value: isSelected)
                
                Circle()
                    .stroke(lineWidth: isSelected ? 0 : minSize / 2)
//                    .strokeBorder(style: StrokeStyle(lineWidth: isSelected ? 0 : minSize / 2))
                    .foregroundColor(isSelected ? selectColor : normalColor)
                    .scaleEffect(scaleCircle)
                    .opacity(isSelected ? 1 : 0)
                    .animation(isSelected ? Animation.easeOut(duration: 0.31) : Animation.easeOut(duration: 0), value: isSelected)
                
                ZStack {
                    FabulaLikeEffect(scale: $scaleSmall, tickCount: 7, size: minSize * 0.08)
                        .foregroundColor(isSelected ? effectColor : normalColor)
                        .scaleEffect(isSelected ? 1.6 : 0.0001)
                        .opacity(isSelected ? 1 : 0)
                        .rotationEffect(isSelected ? Angle(degrees: 6) : Angle(degrees: 24))
                        .animation(isSelected ? Animation.spring(response: 0.28, dampingFraction: 0.8, blendDuration: 0.86).delay(0.10) : Animation.easeOut(duration: 0), value: isSelected)
                    
                    FabulaLikeEffect(scale: $scaleLarge, tickCount: 7, size: minSize * 0.1)
                        .foregroundColor(isSelected ? effectColor : normalColor)
                        .scaleEffect(isSelected ? 2 : 0.0001)
                        .opacity(isSelected ? 1 : 0)
                        .animation(isSelected ? Animation.spring(response: 0.28, dampingFraction: 0.8, blendDuration: 0.86).delay(0.16) : Animation.easeOut(duration: 0), value: isSelected)
                }
            }
            .animation(Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.8), value: isSelected)
            .frame(width: minSize, height: minSize, alignment: .center)
            
            
            .onChange(of: isSelected) {
                withAnimation(Animation.spring(response: 0.34, dampingFraction: 0.6, blendDuration: 0.8)) {
                    if isSelected {
                        self.scaleSmall = 1.0
                        self.scaleLarge = 1.0
                        self.scaleCircle = 1.6
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.scaleSmall = 0.0001
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.scaleLarge = 0.0001
                        }
                    }else {
                        self.scaleSmall = 0.0001
                        self.scaleLarge = 0.0001
                        self.scaleCircle = 0.0001
                    }
                }
                
            }
        }
    }
}

