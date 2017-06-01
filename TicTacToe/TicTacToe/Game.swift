//
//  Game.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

struct Game {
    var playerSymbol: GameSymbol = GameSymbol.X
    var computerSymbol : GameSymbol = GameSymbol.O
    var playerScore = 0
    var computerScore = 0
    
    func playerScoreDescription() -> String {
        return "\(playerScore) - Jogador"
    }
    
    func computerScoreDescription() -> String {
        return "\(computerScore) - Phone"
    }
}
