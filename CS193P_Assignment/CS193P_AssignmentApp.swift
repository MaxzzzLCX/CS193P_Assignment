//
//  CS193P_AssignmentApp.swift
//  CS193P_Assignment
//
//  Created by Max Lyu on 2023/9/19.
//

import SwiftUI

@main
struct CS193P_AssignmentApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
