//
//  EmojiMemoryGameView.swift
//  CS193P - Assignment 2
//
//  Created by Max Lyu on 2023/9/17.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()//ViewModel points to View
    
//    @State var emojis: Array<String> =  []
//    let animals = ["🙈","🐥","🐶","🐱","🐻","🐧"]
//    let food = ["🍎","🍋","🥐","🍳","🍔","🌮","🍍","🥘"]
//    let vehicles = ["🚝","🚀","⛵️","🚁","🛴"]
    
//    @State var themeColor: Color = .green
//
//    @State var cardCount: Int = 4
//    @State var currentTheme: String = "Animals"
    
    
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("NewGame"){}
            
            
            
            
            
//            Button("Shuffle"){
//                viewModel.shuffle()
//            }
            
            // Spacer()
            // themeSelection
            // cardCountAdjuster
        }
        .padding()
    }
    
    var title: some View{
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    
    var cards: some View{
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 85),spacing: 0)], spacing: 0){
            
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
//        .foregroundColor(themeColor)
    }
    
    
    
//    var themeSelection: some View{
//        HStack{
//            Spacer()
//            animalTheme
//            Spacer()
//            foodTheme
//            Spacer()
//            vehicleTheme
//            Spacer()
//        }
//    }
    
//    func themeButtonCreation(caption: String, symbol: String, themeEmojis: [String], color: Color) -> some View{
//
//        Button(action: {
//            emojis = themeEmojis + themeEmojis
//                .shuffled()
//            themeColor = color
//        }, label: {
//            VStack{
//                Image(systemName: symbol).font(.largeTitle)
//                Text(caption)
//            }
//        })
//    }
//
//    var animalTheme: some View{
//        themeButtonCreation(caption: "Animals", symbol: "pawprint.fill", themeEmojis: animals, color: .green)
//    }
//    var foodTheme: some View{
//        themeButtonCreation(caption: "Food", symbol: "fork.knife.circle", themeEmojis: food, color: .red)
//    }
//    var vehicleTheme: some View{
//        themeButtonCreation(caption: "Vehicles", symbol: "car.fill", themeEmojis: vehicles, color: .black)
//    }
    
    
    // THE FOLLOWING IS FROM LECTURE. NOT NEEDED FOR ASSIGNMENT
//    var cardCountAdjuster: some View{
//        HStack{
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
        
//
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//
    
    
//    var cardRemover: some View{
//        cardCountAdjuster(by: -1, symbol:"rectangle.stack.badge.minus.fill")
//    }
//
//    var cardAdder: some View{
//        cardCountAdjuster(by: 1, symbol:"rectangle.stack.badge.plus.fill")
//    }
//
    // THE ABOVE IS FROM LECTURE. NOT NEEDED FOR ASSIGNMENT
    
    
}


struct CardView: View{
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
