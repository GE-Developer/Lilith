//
//  View + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI

// MARK: - Transition Modifier
extension View {
    /// Applies a custom tab transition animation to the view based on the previous and current tab indices.
    ///
    /// - Parameters:
    ///   - previousTab: The index of the previous tab.
    ///   - currentTab: The index of the current tab.
    ///
    /// - Returns: A view with the applied asymmetric transition and opacity animation.
    ///
    func tabTransition(previousTab: Int, currentTab: Int) -> some View {
        // Determine the direction of the transition (forward or backward)
        let isForward = previousTab < currentTab
        
        // Set the insertion and removal edges for the transition
        // If moving forward, insert from trailing and remove from leading. Otherwise, reverse it.
        let insertionEdge: Edge = isForward ? .trailing : .leading
        let removalEdge: Edge = isForward ? .leading : .trailing
        
        // Create an asymmetric transition using the specified edges
        let transition: AnyTransition = .asymmetric(
            insertion: .move(edge: insertionEdge),
            removal: .move(edge: removalEdge)
        )

        // Return the view with the applied transition, combined with an opacity change
        return self.transition(
            transition.combined(with: .opacity)
        )
    }
}
