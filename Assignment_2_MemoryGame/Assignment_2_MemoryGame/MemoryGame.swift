//
//  MemoryGame.swift
//  Assignment_2_MemoryGame
//
//  Created by Yingzhe Hu on 6/25/24.
//
//  Model

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choosing(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = true
        
        let content: CardContent
    }
}
