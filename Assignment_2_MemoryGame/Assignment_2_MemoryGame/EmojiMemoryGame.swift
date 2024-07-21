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
    private static let themes = [
        ["😀", "😃", "😂", "😍", "😇", "🥸", "🥳", "⚽️", "🏀", "🏈"],
        ["🐶", "🐱", "🐭", "🐰", "🐻", "🐼", "🐻‍❄️", "🐯", "🐮", "🐷", "🐔"]
    ]
    private static let themesName = ["Emojis", "Animals"]
    
    private static var themeIndex = 0
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let shuffledEmojis = themes[themeIndex].shuffled()
        return MemoryGame(numberOfPairsOfCards: Int.random(in: 0..<themes[themeIndex].count)) { index in
            if shuffledEmojis.indices.contains(index) {
                return shuffledEmojis[index]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var themeName: String {
        return EmojiMemoryGame.themesName[EmojiMemoryGame.themeIndex]
    }
    
    var score: Int {
        return model.totalScore
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choosing(card)
    }
    
    func shuffle() {
        model.shuffle()
//        objectWillChange.send()
    }
    
    func startANewGame() {
        // select a random theme
        EmojiMemoryGame.themeIndex = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        model = EmojiMemoryGame.createMemoryGame()
    }
}
