//
//  ViewController.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum GameSymbol {
        case X, O
        
        func imageName() -> String {
            switch self {
            case .X:
                return "x"
            default:
                return "o"
            }
        }
    }
    
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
    
    class Presenter {
        
        weak var view: ViewController?
        var model: Model
        
        init() {
            self.model = Model()
        }
        
        func selectSymbol(symbol: GameSymbol) {
            model.playerSymbol = symbol
            
            switch symbol {
            case .O:
                model.computerSymbol = .X
            case .X:
                model.computerSymbol = .O
            }
            
            view?.presentBoard(game: model.getGame())
        }
        
    }
    
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
    
    var presenter: Presenter!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = Presenter()
        self.presenter.view = self
    }

    @IBAction func selectX(_ sender: Any) {
        presenter.selectSymbol(symbol: GameSymbol.X)
    }
    
    @IBAction func selectO(_ sender: Any) {
        presenter.selectSymbol(symbol: GameSymbol.O)
    }
    
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
