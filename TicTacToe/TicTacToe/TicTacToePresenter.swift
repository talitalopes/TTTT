//
//  TicTacToePresenter.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

class TicTacToePresenter {
    
    weak var view: TicTacToeView?
    private var game: Game
    
    init(playerSymbol: GameSymbol, view: TicTacToeView?) {
        self.game = Game(playerSymbol: playerSymbol)
        self.view = view
        self.view?.presentBoard(game: game)
        computerMove()
    }
    
    func playerMove(at index: Int) {
        if !game.isPositionFree(index) {
            return
        }
        
        game.playerMove(at: index)
        view?.drawSymbol(at: index, symbol: game.playerSymbol)
        
        if game.hasWinner() {
            game.blockGame()
            game.incrementPlayerScore()
            view?.showWinner(game, player: true)
            return
        }
        
        if game.isOver() {
            view?.gameOver()
            return
        }
        
        game.waitForComputer()
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .microseconds(250_000)) {
            self.computerMove()
        }
    }
    
    func computerMove() {
        let index = game.computerMove()
        view?.drawSymbol(at: index, symbol: game.computerSymbol)
        
        if game.hasWinner() {
            game.blockGame()
            game.incrementComputerScore()
            view?.showWinner(game, player: false)
            return
        }
        
        if game.isOver() {
            view?.gameOver()
            return
        }
        
        game.waitForPlayer()
    }
    
    func restartGame() {
        game.reset()
        view?.setupBoard(game: game)
    }
}
