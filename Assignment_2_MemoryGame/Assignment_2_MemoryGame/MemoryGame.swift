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
    
//    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
//            let faceUpCaradIndices = cards.indices.filter { index in cards[index].isFaceUp }
//            return faceUpCaradIndices.count == 1 ? faceUpCaradIndices.first : nil
            return cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set { // newValue
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                } else {
//                    cards[index].isFaceUp = false
//                }
//            }
//            cards.indices.forEach { index in cards[index].isFaceUp = (index == newValue) }
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for index in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(index)
            cards.append(Card(content: content, id: "\(index+1)a"))
            cards.append(Card(content: content, id: "\(index+1)b"))
        }
    }
    
    mutating func choosing(_ card: Card) {
//        if let chosenIndex = index(of: card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
//                    indexOfTheOneAndOnlyFaceUpCard = nil
                } else {
//                    for index in cards.indices {
//                        cards[index].isFaceUp = false
//                    }
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
//    private func index(of chosenCard: Card) -> Int? {
//        for (i, card) in cards.enumerated() {
//            if card.id == chosenCard.id {
//                return i
//            }
//        }
//        return nil // FIXME: bogus!
//    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        
        let content: CardContent
//        var id = UUID()
        var id: String
        
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched
//        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
