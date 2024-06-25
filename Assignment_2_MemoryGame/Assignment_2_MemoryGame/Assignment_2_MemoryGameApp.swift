//
//  Assignment_2_MemoryGameApp.swift
//  Assignment_2_MemoryGame
//
//  Created by Yingzhe Hu on 6/25/24.
//

import SwiftUI

@main
struct Assignment_2_MemoryGameApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
