//
//  ViewController.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    var presenter: TicTacToePresenter!
}

//// --- Lyfecycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TicTacToePresenter()
        self.presenter.view = self
    }
    
}

//// --- IBActions

extension ViewController {
    
    @IBAction func selectX(_ sender: Any) {
        presenter.selectSymbol(symbol: GameSymbol.X)
    }
    
    @IBAction func selectO(_ sender: Any) {
        presenter.selectSymbol(symbol: GameSymbol.O)
    }
    
}

//// --- Game View

extension ViewController {
    
    func presentBoard(game: Game) {
        hideIntroductionView()
        setupBoard(game: game)
        moveSymbolsToDisplayGameStatus(game: game)
    }
    
}

private extension ViewController {
    
    func hideIntroductionView() {
        UIView.transition(
            with: self.view,
            duration: 0.2,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: { () in self.introductionStackView.isHidden = true },
            completion: nil)
    }
    
    func setupBoard(game: Game) {
        playerSymbolView.image = UIImage(named: game.playerSymbol.imageName())
        computerSymbolView.image = UIImage(named: game.computerSymbol.imageName())
        playerScoreView.text = game.playerScoreDescription()
        computerScoreView.text = game.computerScoreDescription()
    }
    
    func moveSymbolsToDisplayGameStatus(game: Game) {
        UIView.transition(
            with: self.view,
            duration: 0.3,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: { [unowned self] () in
                self.containerOSymbol.isHidden = true
                self.containerXSymbol.isHidden = true
                self.playerStackView.isHidden = false
                self.computerStackView.isHidden = false
            },
            completion: nil)
    }
    
}
