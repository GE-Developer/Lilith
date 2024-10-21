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
    
    @Environment(\.scenePhase) private var scenePhase
    @GestureState private var dragState: CGSize = .zero
    @State private var offset: CGFloat = .zero
    
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
        .onDisappear { returnCell() }
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
}

// MARK: - Work with gestures
extension SwipeableCardCellView {
    private var gestureZone: some View {
        Circle()
            .frame(height: cellHeight / 2)
            .foregroundStyle(.clear)
            .contentShape(Circle())
            .gesture(gestureAction)
            .task(id: scenePhase) {
                if scenePhase != .active {
                    gestureEnded()
                }
            }
    }
    
    private var gestureAction: some Gesture {
        DragGesture(minimumDistance: 3, coordinateSpace: .global)
            .updating($dragState) { gestureChange($0, &$1, $2) }
            .onEnded { _ in gestureEnded() }
    }
    
    private func gestureChange(_ value: DragGesture.Value, _ state: inout CGSize, _ transaction: Transaction) {
        guard scenePhase == .active, value.translation.width < 0 else { return }
        swipeStarted()
        
        state = value.translation
        let xGesture = state.width
        offset = max(min(max(xGesture, -70 + xGesture / 3), 0), -350)
    }
    
    private func gestureEnded() {
        guard offset < -40, scenePhase == .active else { return returnCell() }
        
        withAnimation(.easeInOut(duration: 0.2)) {
            offset = -110
        } completion: {
            likeAction()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                returnCell()
            }
        }
    }
    
    private func returnCell() {
        guard offset != 0 else { return }
        withAnimation(.easeOut(duration: 0.5)) {
            offset = .zero
        } completion: {
            isGestureEnabled = true
            swipedCardID = nil
        }
    }
    
    private func swipeStarted() {
        if isGestureEnabled {
            isGestureEnabled = false
            swipedCardID = vm.cardID
        }
    }
    
    private func likeAction() {
        if vm.isLiked {
            vm.cardsViewModel.deleteCard(ids: [vm.cardID])
        } else {
            vm.cardsViewModel.addCard(id: vm.cardID)
        }
    }
}
