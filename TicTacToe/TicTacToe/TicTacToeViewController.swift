//
//  ViewController.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    @IBOutlet weak var playerStackView: UIStackView!
    @IBOutlet weak var playerSymbolView: UIImageView!
    @IBOutlet weak var playerScoreView: UILabel!
    @IBOutlet weak var computerStackView: UIStackView!
    @IBOutlet weak var computerSymbolView: UIImageView!
    @IBOutlet weak var computerScoreView: UILabel!
    @IBOutlet weak var introductionStackView: UIStackView!
    
    @IBOutlet weak var containerOSymbol: UIView! {
        didSet {
            containerOSymbol.layer.borderColor = UIColor.lightGray.cgColor
            containerOSymbol.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var containerXSymbol: UIView! {
        didSet {
            containerXSymbol.layer.borderColor = UIColor.lightGray.cgColor
            containerXSymbol.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet var boardButtons: [UIButton]!
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var endOfGameMessageLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    var presenter: TicTacToePresenter!
}

//// --- Lyfecycle

extension TicTacToeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//// --- IBActions

extension TicTacToeViewController {
    
    @IBAction func selectX(_ sender: Any) {
        presenter = TicTacToePresenter(playerSymbol: GameSymbol.X, view: self)
    }
    
    @IBAction func selectO(_ sender: Any) {
        presenter = TicTacToePresenter(playerSymbol: GameSymbol.O, view: self)
    }
 
    @IBAction func playAtPosition(sender: UIButton!) {
        presenter.playerMove(at: sender.tag)
    }
    
    @IBAction func restartGame(sender: UIButton) {
        presenter.restartGame()
    }
    
}

//// --- Game View

extension TicTacToeViewController : TicTacToeView {
    
    func presentBoard(game: Game) {
        hideIntroductionView()
        setupBoard(game: game)
        moveSymbolsToDisplayGameStatus(game: game)
    }
 
    func drawSymbol(at index: Int, symbol: GameSymbol) {
        let image = UIImage(named: symbol.name())
        boardButtons[index].setImage(image, for: UIControlState.normal)
    }
    
    func showWinner(_ game: Game, player: Bool) {
        if player {
            endOfGameMessageLabel.text = "Parabéns, você ganhou!"
        } else {
            endOfGameMessageLabel.text = "Vamos jogar mais uma vez?"
        }
        newGameButton.isHidden = false
        endOfGameMessageLabel.isHidden = false
        playerScoreView.text = game.playerScoreDescription()
        computerScoreView.text = game.computerScoreDescription()
        
        for index in game.winnerSpots {
            boardButtons[index].tintColor = UIColor.winnerTintColor()
        }
    }
    
    func gameOver() {
        UIView.transition(
            with: self.view,
            duration: 0.1,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: { [unowned self] () in
                self.endOfGameMessageLabel.isHidden = false
                self.endOfGameMessageLabel.text = "Parece que vai ficar pra próxima :("
                self.newGameButton.isHidden = false
            },
            completion: nil)
    }
    
    func setupBoard(game: Game) {
        for i in 0...8 {
            boardButtons[i].setImage(nil, for: .normal)
            boardButtons[i].tintColor = UIColor.defaultTintColor()
        }
        
        playerSymbolView.image = UIImage(named: game.playerSymbol.name())
        computerSymbolView.image = UIImage(named: game.computerSymbol.name())
        endOfGameMessageLabel.isHidden = true
        newGameButton.isHidden = true
    }
}

private extension TicTacToeViewController {
    
    func hideIntroductionView() {
        UIView.transition(
            with: self.view,
            duration: 0.2,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: { () in self.introductionStackView.isHidden = true },
            completion: nil)
    }
    
    func moveSymbolsToDisplayGameStatus(game: Game) {
        UIView.transition(
            with: self.view,
            duration: 0.3,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: { [unowned self] () in
                self.endOfGameMessageLabel.isHidden = true
                self.newGameButton.isHidden = true
                self.containerOSymbol.isHidden = true
                self.containerXSymbol.isHidden = true
                self.playerStackView.isHidden = false
                self.computerStackView.isHidden = false
                self.gameBoard.isHidden = false
            },
            completion: nil)
    }
    
}
