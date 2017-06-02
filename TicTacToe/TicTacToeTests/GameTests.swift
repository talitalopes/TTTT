//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Talita Lopes on 6/2/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    var game: Game!
    
    override func setUp() {
        super.setUp()
        game = Game(playerSymbol: GameSymbol.O)
    }
    
    override func tearDown() {
        super.tearDown()
        game.reset()
    }
    
    func testAssertPlayerSymbolIsO() {
        XCTAssertTrue(game.playerSymbol.name() == "o", "bad player symbol")
    }
    
    func testAssertComputerSymbolIsX() {
        XCTAssertTrue(game.computerSymbol.name() == "x", "bad computer symbol")
    }
    
    func testAssertPlayerSymbolIsX() {
        game = Game(playerSymbol: GameSymbol.X)
        XCTAssertTrue(game.playerSymbol.name() == "x", "bad player symbol")
    }
    
    func testAssertComputerSymbolIsO() {
        game = Game(playerSymbol: GameSymbol.X)
        XCTAssertTrue(game.computerSymbol.name() == "o", "bad computer symbol")
    }
    
    func testAssetBoardIsEmpty() {
        XCTAssertTrue(game.availablePositions.count == 9, "board starts empty")
    }
    
    func testPlayerScoreDescription() {
        XCTAssertEqual("0 - Jogador", game.playerScoreDescription())
    }
    
    func testComputerScoreDescription() {
        XCTAssertEqual("0 - Phone", game.computerScoreDescription())
    }
    
    func testAvailablePositionsUpdateAfterPlayerMove() {
        game.playerMove(at: 0)
        XCTAssertTrue(game.availablePositions.count == 8, "Player move computed")
        XCTAssertFalse(game.isPositionFree(0), "Player move computed")
    }
    
    func testAvailablePositionsUpdateAfterComputerMove() {
        let index = game.computerMove()
        XCTAssertTrue(game.availablePositions.count == 8, "Player move computed")
        XCTAssertFalse(game.isPositionFree(index), "Computer move computed")
    }
    
    func testIfPlayerIsWinner() {
        game.playerMove(at: 0)
        game.playerMove(at: 1)
        game.playerMove(at: 2)
        XCTAssertTrue(game.hasWinner(), "Player should've won on line 1")
        
        var set = Set<Int>()
        set.insert(0)
        set.insert(1)
        set.insert(2)
        XCTAssertEqual(game.winnerSpots, set, "Winner spots are wrong")
    }
    
    func testIfComputerSelectsCornerIfAvailable() {
        let index = game.computerMove()
        XCTAssertTrue([0, 2, 6, 8].filter{ $0 == index}.count > 0, "Computer should've selected corner")
    }
    
    func testIfComputerSelectsMiddlePosition() {
        game = Game(playerSymbol: GameSymbol.O, board : ["o", "x", "o", "", "", "x", "x", "o", "o"])
        let index = game.computerMove()
        XCTAssertTrue(index == 4, "Computer should've selected corner")
    }

    func testComputerBlocksPlayerMoveForHorizontalLine() {
        game.playerMove(at: 0)
        game.playerMove(at: 2)
        let index = game.computerMove()
        XCTAssertTrue(index == 1, "Computer should've blocked player move")
    }
    
    func testComputerBlocksPlayerMoveForVerticalLine() {
        game.playerMove(at: 0)
        game.playerMove(at: 6)
        let index = game.computerMove()
        XCTAssertTrue(index == 3, "Computer should've blocked player move")
    }
    
    func testComputerBlocksPlayerMoveForDiagonal() {
        game.playerMove(at: 0)
        game.playerMove(at: 8)
        let index = game.computerMove()
        XCTAssertTrue(index == 4, "Computer should've blocked player move")
    }

    func testComputerSelectesWinningPosition() {
        game = Game(playerSymbol: GameSymbol.O, board : ["x", "", "x", "", "", "", "", "", ""])
        let index = game.computerMove()
        XCTAssertTrue(index == 1, "Computer should've selected winning position")
    }
    
    func testPlayerScore() {
        game.incrementPlayerScore()
        XCTAssertTrue(game.playerScore == 1, "Player score is wrong")
        XCTAssertEqual("1 - Jogador", game.playerScoreDescription())
    }
    
    func testComputerScore() {
        game.incrementComputerScore()
        XCTAssertTrue(game.computerScore == 1, "Computer score is wrong")
        XCTAssertEqual("1 - Phone", game.computerScoreDescription())
    }
    
    func testPlayerIsBlockedWhileWaitingForComputer() {
        game.waitForComputer()
        XCTAssertFalse(game.isPositionFree(0), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(1), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(2), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(3), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(4), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(5), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(6), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(7), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(8), "Player move is blocked")
    }
    
    func testBlockGame() {
        game.blockGame()
        XCTAssertTrue(game.availablePositions.isEmpty, "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(0), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(1), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(2), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(3), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(4), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(5), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(6), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(7), "Player move is blocked")
        XCTAssertFalse(game.isPositionFree(8), "Player move is blocked")
    }
    
    func testPlayerIsAllowedToPlay() {
        game.waitForComputer()
        XCTAssertFalse(game.isPositionFree(0), "Player move wasnot blocked")
        game.waitForPlayer()
        XCTAssertTrue(game.isPositionFree(0), "Player move wasnot blocked")
        game.playerMove(at: 0)
        XCTAssertFalse(game.isPositionFree(0), "Player move is blocked")
    }
    
    
}
