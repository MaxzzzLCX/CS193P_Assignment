//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Max Lyu on 2023/8/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    var score: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        // can directly do cards=[], because from above we know cards is of type Card
        
        for index in 0..<max(2, 2*numberOfPairsOfCards){
            let content = cardContentFactory(index)
            cards.append(Card(content: content, id: "\(index+1)"))
        }
        score = 0
    }
    
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{ cards.indices.filter{index in cards[index].isFaceUp}.only }
        set{ cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}){
            
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                
                if let previousChoosen = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[previousChoosen].content{
                        cards[chosenIndex].isMatched = true
                        cards[previousChoosen].isMatched = true
                        score += 2
                    }
                    else{
                        if cards[chosenIndex].hasSeen{
                            score -= 1
                        }
                        if cards[previousChoosen].hasSeen{
                            score -= 1
                        }
                        cards[chosenIndex].hasSeen = true
                        cards[previousChoosen].hasSeen = true
                    }
                }else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
            
            
            
        }
    }
    
    mutating func newGame(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    //nested struct
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        
        var isFaceUp = false
        var isMatched = false
        var hasSeen = false
        let content: CardContent
        
        var id: String
        
        var debugDescription: String{
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

struct Theme: Equatable{
    var name: String
    var emojis: Array<String>
    var numberOfPairs: Int
    var color: String
}



extension Array {
    var only: Element?{
        count == 1 ? first : nil
    }
}
