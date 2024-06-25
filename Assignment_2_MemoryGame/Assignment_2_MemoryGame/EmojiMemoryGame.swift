//
//  EmojiMemoryGame.swift
//  Assignment_2_MemoryGame
//
//  Created by Yingzhe Hu on 6/25/24.
//
// View Model

import Foundation
import SwiftUI
import Combine

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["😀", "😃", "😂", "😍", "😇", "🥸", "🥳"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 16) { index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "⁉️"
            }
        }
    }
    
//    var objectWillChange = ObservableObjectPublisher()
    
    @Published var model: MemoryGame<String> = MemoryGame(
        numberOfPairsOfCards: 16) { index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "⁉️"
            }
        }
    
//    @Published var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choosing(card)
    }
    
    func shuffle() {
        model.shuffle()
//        objectWillChange.send()
    }
}
