//
//  TicTacToePresenter.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

class TicTacToePresenter {
    
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
