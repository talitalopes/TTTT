//
//  Game.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

struct Game {
    fileprivate var board = ["", "", "", "", "", "", "", "", ""]
    
    let playerSymbol: GameSymbol
    let computerSymbol : GameSymbol
    var playerScore = 0
    var computerScore = 0
    var availablePositions = Array(0...8)
    var userOnHold = false
    var winnerSpots = Set<Int>()
    
    init(playerSymbol: GameSymbol) {
        self.playerSymbol = playerSymbol
        
        switch playerSymbol {
        case .O:
            self.computerSymbol = .X
        case .X:
            self.computerSymbol = .O
        }
        
        board = ["", "", "", "", "", "", "", "", ""]
    }
    
    init(playerSymbol: GameSymbol, board: [String]) {
        self.init(playerSymbol: playerSymbol)
        self.board = board
    }
    
    func playerScoreDescription() -> String {
        return "\(playerScore) - Jogador"
    }
    
    func computerScoreDescription() -> String {
        return "\(computerScore) - Phone"
    }
    
    mutating func playerMove(at index: Int) {
        play(at: index, symbol: playerSymbol)
    }
    
    func computeComputerMove() -> Int {
        for index in availablePositions.shuffled() {
            var boardCopy = board
            if boardCopy[index].isEmpty {
                boardCopy[index] = computerSymbol.name()
                let winnerSpots = computeWinner(boardCopy, symbol: computerSymbol)
                if !winnerSpots.isEmpty {
                    return index
                }
            }
        }
        
        for index in availablePositions.shuffled() {
            var boardCopy = board
            if boardCopy[index].isEmpty {
                boardCopy[index] = playerSymbol.name()
                let winnerSpots = computeWinner(boardCopy, symbol: playerSymbol)
                if !winnerSpots.isEmpty {
                    return index
                }
            }
        }
        
        for index in [0, 2, 6, 8].shuffled() {
            if board[index].isEmpty {
                return index
            }
        }
        
        if board[4].isEmpty {
            return 4
        }
        
        for index in [1, 3, 5, 7].shuffled() {
            if board[index].isEmpty {
                return index
            }
        }
        
        return -1
    }
    
    mutating func computerMove() -> Int {
        let index = computeComputerMove()
        if (index >= 0) {
            play(at: index, symbol: computerSymbol)
        }
        return index
    }
    
    func isPositionFree(_ index: Int) -> Bool {
        return board[index].isEmpty && !availablePositions.isEmpty && !userOnHold
    }
    
    func hasWinner() -> Bool {
        return !winnerSpots.isEmpty
    }
    
    func isOver() -> Bool {
        return availablePositions.isEmpty
    }
    
    mutating func reset() {
        board = ["", "", "", "", "", "", "", "", ""]
        availablePositions = Array(0...8)
        userOnHold = false
        winnerSpots = Set<Int>()
    }
    
    mutating func blockGame() {
        availablePositions = []
    }
    
    mutating func incrementPlayerScore() {
        self.playerScore = self.playerScore + 1
    }
    
    mutating func incrementComputerScore() {
        self.computerScore = self.computerScore + 1
    }
    
    mutating func waitForComputer() {
        self.userOnHold = true
    }
    
    mutating func waitForPlayer() {
        self.userOnHold = false
    }
}

fileprivate extension Game {
    
    mutating func play(at index: Int, symbol: GameSymbol) {
        board[index] = symbol.name()
        availablePositions = availablePositions.filter { $0 != index }
        winnerSpots = computeWinner(board, symbol: symbol)
    }

    func computeWinner(_ board: [String], symbol: GameSymbol) -> Set<Int> {
        var winnerSpots = Set<Int>()
        if board[0] == symbol.name() && board[0] == board[1] && board[0] == board[2] && board[1] == board[2] {
            winnerSpots.insert(0)
            winnerSpots.insert(1)
            winnerSpots.insert(2)
        }
        
        if board[3] == symbol.name() && board[3] == board[4] && board[3] == board[5] && board[4] == board[5] {
            winnerSpots.insert(3)
            winnerSpots.insert(4)
            winnerSpots.insert(5)
        }
        
        if board[6] == symbol.name() && board[6] == board[7] && board[6] == board[8] && board[7] == board[8] {
            winnerSpots.insert(6)
            winnerSpots.insert(7)
            winnerSpots.insert(8)
        }
        
        if board[0] == symbol.name() && board[0] == board[3] && board[0] == board[6] && board[3] == board[6] {
            winnerSpots.insert(0)
            winnerSpots.insert(3)
            winnerSpots.insert(6)
        }
        
        if board[1] == symbol.name() && board[1] == board[4] && board[1] == board[7] && board[4] == board[7] {
            winnerSpots.insert(1)
            winnerSpots.insert(4)
            winnerSpots.insert(7)
        }
        
        if board[2] == symbol.name() && board[2] == board[5] && board[2] == board[8] && board[5] == board[8] {
            winnerSpots.insert(2)
            winnerSpots.insert(5)
            winnerSpots.insert(8)
        }
        
        if board[0] == symbol.name() && board[0] == board[4] && board[0] == board[8] && board[4] == board[8] {
            winnerSpots.insert(0)
            winnerSpots.insert(4)
            winnerSpots.insert(8)
        }
        
        if board[2] == symbol.name() && board[2] == board[4] && board[2] == board[6] && board[4] == board[6] {
            winnerSpots.insert(2)
            winnerSpots.insert(4)
            winnerSpots.insert(6)
        }
        return winnerSpots
    }
    
}
