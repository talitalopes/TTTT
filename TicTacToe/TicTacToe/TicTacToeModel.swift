//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

class Model {
    private var game: Game
    
    init() {
        self.game = Game()
    }
    
    var playerSymbol : GameSymbol {
        set {
            game.playerSymbol = newValue
        }
        get {
            return game.playerSymbol
        }
    }
    
    var computerSymbol : GameSymbol {
        set {
            game.computerSymbol = newValue
        }
        get {
            return game.computerSymbol
        }
    }
    
    func getGame() -> Game {
        return game
    }
}
