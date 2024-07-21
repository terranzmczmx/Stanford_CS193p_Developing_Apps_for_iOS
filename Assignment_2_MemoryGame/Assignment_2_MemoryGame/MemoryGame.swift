//
//  MemoryGame.swift
//  Assignment_2_MemoryGame
//
//  Created by Yingzhe Hu on 6/25/24.
//
//  Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var totalScore: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for index in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(index)
            cards.append(Card(content: content, id: "\(index+1)a"))
            cards.append(Card(content: content, id: "\(index+1)b"))
        }
        shuffle()
    }
    
    mutating func choosing(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                        totalScore += 2
                    } else {
                        totalScore += cards[potentialMatchIndex].score + cards[chosenIndex].score
                        cards[potentialMatchIndex].score = -1
                        cards[chosenIndex].score = -1
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        
        let content: CardContent
        var id: String
        var score: Int = 0
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
