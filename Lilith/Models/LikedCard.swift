//
//  LikedCard.swift
//  Lilith
//
//  Created by Mikhail Bukhrashvili on 09.10.24.
//

import SwiftData

// MARK: - Model representing a liked card.

/// The class is used to store information about cards that have been marked as liked by the user.
@Model
final class LikedCard {
    /// Unique identifier of the card.
    var id: String = ""
    
    /// Identifier of the deck to which the card belongs.
    var deckID: String = ""
    
    /// Order of the card in the deck.
    var order: Int = 0
    
    /// Initializer to create an instance of a liked card.
    /// - Parameters:
    ///   - id: Unique identifier of the card.
    ///   - deckID: Identifier of the deck to which the card belongs.
    ///   - order: Order of the card in the deck.
    init(_ id: String, _ deckID: String, at order: Int) {
        self.id = id
        self.deckID = deckID
        self.order = order
    }
}
