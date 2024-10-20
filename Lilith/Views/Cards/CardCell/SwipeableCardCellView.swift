//
//  CardCellView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

struct SwipeableCardCellView: View {
    @ObservedObject var vm: CardCellViewModel
    @Binding var isGestureEnabled: Bool
    @Binding var swipedCardID: String?
    
    @State private var offset: CGFloat = 0
    
    let cellHeight: Double
    
    var body: some View {
        GeometryReader { geometry in
            let geometryWidth = geometry.size.width
            
            ZStack(alignment: .leading) {
                CardCellView(vm: vm, cellHeight: cellHeight)
                
                gestureZone
                    .offset(x: geometryWidth - cellHeight / 2)
                
                likeAndDeleteSwipeView
                    .offset(x: geometryWidth + 16 - offset / 2.25 - cellHeight / 7)
            }
            .offset(x: offset)
        }
        .frame(maxWidth: .infinity)
        .frame(height: cellHeight)
        .onDisappear { resetOffset() }
    }
    
    private var likeAndDeleteSwipeView: some View {
        ExplosiveLikeView(
            isSelected: vm.isLiked,
            image: Image.system.heart,
            imageFill: Image.system.heartFill
        )
        .frame(width: cellHeight / 4.5 ,height: cellHeight / 4.5)
        .scaleEffect(max(min(0.1 - offset / 100, 1), 0.0001))
        .opacity(max(min(0 - Double(offset) / 100, 1), 0))
    }
    
    private func resetOffset() {
        if offset != 0 {
            offset = 0
        }
    }
}

// MARK: - Work with gestures
 extension SwipeableCardCellView {
    private var gestureZone: some View {
        Circle()
            .frame(height: cellHeight / 2)
            .foregroundStyle(.clear)
            .contentShape(Circle())
            .gesture(gestureAction)
    }
    
    private var gestureAction: some Gesture {
        DragGesture(minimumDistance: 3, coordinateSpace: .global)
            .onChanged { gestureChange($0) }
            .onEnded { gestureEnded($0) }
    }
    
    private func gestureChange(_ gesture: DragGesture.Value) {
        isGestureEnabled = false
        swipedCardID = vm.cardID
        let xGesture = gesture.translation.width
        let xOffset = max(xGesture, -70 + xGesture / 3)
        
        withAnimation(.linear(duration: 0.05)) {
            offset = max(min(xOffset, 0), -350)
        }
    }
    
    private func gestureEnded(_ gesture: DragGesture.Value) {
        if offset < -40 {
            
            withAnimation(.easeInOut(duration: 0.2)) {
                offset = -110
            } completion: {
                if vm.isLiked {
                    vm.cardsViewModel.deleteCard(ids: [vm.cardID])
                } else {
                    vm.cardsViewModel.addCard(id: vm.cardID)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        offset = 0
                    } completion: {
                        isGestureEnabled = true
                        swipedCardID = nil
                    }
                }
            }
        } else {
            withAnimation(.easeOut(duration: 0.5)) {
                offset = 0
            } completion: {
                isGestureEnabled = true
                swipedCardID = nil
            }
        }
    }
}

