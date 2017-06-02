//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

protocol TicTacToeView : class {
    func presentBoard(game: Game)
    func setupBoard(game: Game)
    func drawSymbol(at index: Int, symbol: GameSymbol)
    func showWinner(_ game: Game, player: Bool)
    func gameOver()
}
