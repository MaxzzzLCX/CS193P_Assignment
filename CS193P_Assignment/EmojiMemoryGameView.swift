//
//  EmojiMemoryGameView.swift
//  CS193P - Assignment 2
//
//  Created by Max Lyu on 2023/9/17.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()//ViewModel points to View
    
    
    var body: some View {
        VStack{
            HStack{
                title
                Spacer()
                score
            }
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("NewGame"){
                viewModel.newGame()
            }
            Spacer()
            themeSelection
            Spacer()

            
            
            
            
            
//            Button("Shuffle"){
//                viewModel.shuffle()
//            }
            
            // cardCountAdjuster
            

        }
        .padding()
    }
    
    var title: some View{
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    var score: some View{
        Text("Score: "+String(viewModel.score))
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
        //.foregroundColor(Color("."+EmojiMemoryGame.currentTheme.color))
        .foregroundColor(EmojiMemoryGame.currentColor)
    }
    
    
    
    var themeSelection: some View{
        VStack{
            HStack{
                Spacer()
                animalTheme
                Spacer()
                foodTheme
                Spacer()
                vehicleTheme
                Spacer()
            }
            HStack{
                Spacer()
                sportTheme
                Spacer()
                countryTheme
                Spacer()
                heartTheme
                Spacer()
            }
            
        }
        
    }
    
    func themeButtonCreation(caption: String, symbol: String) -> some View{

        Button(action: {
            viewModel.changeTheme(to: caption)
        }, label: {
            VStack{
                Image(systemName: symbol).font(.largeTitle)
                Text(caption)
            }
        })
    }

    var animalTheme: some View{
        themeButtonCreation(caption: "Animals", symbol: "pawprint.fill")
    }
    var foodTheme: some View{
        themeButtonCreation(caption: "Food", symbol: "fork.knife.circle")
    }
    var vehicleTheme: some View{
        themeButtonCreation(caption: "Vehicles", symbol: "car.fill")
    }
    var sportTheme: some View{
        themeButtonCreation(caption: "Sports", symbol: "figure.run")
    }
    var countryTheme: some View{
        themeButtonCreation(caption: "Countries", symbol: "location.circle.fill")
    }
    var heartTheme: some View{
        themeButtonCreation(caption: "Hearts", symbol: "heart.circle.fill")
    }
    
    
    
    
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
