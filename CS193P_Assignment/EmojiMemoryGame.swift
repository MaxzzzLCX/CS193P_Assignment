//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Max Lyu on 2023/8/23.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    //private static var emojis = ["🙈","🐥","🐶","🐱","🐻","🐧","🪿","🐽","🐨","🐯","🐸"]
    
    
    static let animals: Theme = Theme(name: "Animals", emojis: ["🙈","🐥","🐶","🐱","🐻","🐧","🪿","🐽","🐨","🐯","🐸"], numberOfPairs: 12, color: "green")
    static let food: Theme = Theme(name: "Food", emojis: ["🍎","🍋","🥐","🍳","🍔","🌮","🍍","🥘"], numberOfPairs: 8, color: "red")
    static let vehicles: Theme = Theme(name: "Vehicles", emojis: ["🚝","🚀","⛵️","🚁","🛴"], numberOfPairs: 5, color: "black")
    static let sports: Theme = Theme(name: "Sports", emojis: ["⚽️","🏀","🏈","⚾️","🥎","🥏","🏓","🏑"], numberOfPairs: 8, color: "blue")
    static let countries: Theme = Theme(name: "Countries", emojis: ["🇦🇷","🇧🇪","🇧🇷","🇨🇦","🇨🇳","🇭🇷"], numberOfPairs: 6, color: "yellow")
    static let hearts: Theme = Theme(name: "Hearts", emojis: ["🩷","❤️","🧡","💛"], numberOfPairs: 4, color: "pink")
    
    static let themes: Array<Theme> = [animals, food, vehicles, sports, countries, hearts]
    
    static let colors: Dictionary<String,Color> = ["green":.green, "red":.red, "black":.black, "blue":.blue, "yellow":.yellow, "pink":.pink]
    
    static var currentTheme = themes.randomElement()!
    
    static var currentColor: Color {
        return EmojiMemoryGame.colors[EmojiMemoryGame.currentTheme.color] ?? .black
    }
    
    
    
    
    private static func createMemoryGame(theme currentTheme: Theme)->MemoryGame<String>{
        let tempEmoji = (currentTheme.emojis+currentTheme.emojis).shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: currentTheme.numberOfPairs){index in
            if tempEmoji.indices.contains(index){
                return tempEmoji[index]
            }else{
                return "⁉️"
            }
        }
    }
    
   
    @Published private var model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)

    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    var score: Int{
        return model.score
    }
    
    // MARK: - Intents
    
    func newGame(){
        EmojiMemoryGame.currentTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.currentTheme)
//        model.newGame()
    }
    
    func changeTheme(to newCaption: String){
        for target in EmojiMemoryGame.themes{
            if target.name == newCaption{
                EmojiMemoryGame.currentTheme = target
                model = EmojiMemoryGame.createMemoryGame(theme: target)
            }
        }
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
