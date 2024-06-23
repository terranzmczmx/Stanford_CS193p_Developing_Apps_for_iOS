//
//  ContentView.swift
//  Assignment 1 Memorize
//
//  Created by Yingzhe Hu on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount = 0
    @State var themeIndex = 0
    var emojis = ["😀", "😃", "😂", "😍", "😇", "🥸", "🥳"]
    @State var themeEmojis = [["🚗", "🚗", "🚌", "🚌", "🏎️", "🏎️", "🚓", "🚓", "🚑", "🚑", "🚜", "🚜"],
                       ["⚽️", "⚽️", "🏀", "🏀", "🏈", "🏈", "⚾️", "⚾️", "🏓", "🏓"],
                       ["🐶", "🐶", "🐱", "🐱", "🐭", "🐭", "🐹", "🐹"]
                      ]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
//            cardCountAdjusters
            themeChoosing
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: themeEmojis[themeIndex][index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 0 || cardCount + offset > emojis.count)
    }
    
    var themeChoosing: some View {
        HStack {
            Spacer()
            theme(by: 0, symbol: "car", name: "Vehicles")
            Spacer()
            theme(by: 1, symbol: "figure.run", name: "Sports")
            Spacer()
            theme(by: 2, symbol: "pawprint", name: "Animals")
            Spacer()
        }
    }
    
    func theme(by index: Int, symbol: String, name: String) -> some View {
        Button(action: {
            themeIndex = index
            cardCount = themeEmojis[themeIndex].count
            themeEmojis[themeIndex].shuffle()
        }, label: {
            VStack {
                Image(systemName: symbol)
//                    .font(.headline)
                    .imageScale(.large)
                Text(name)
                    .font(.body)
            }
        })
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
