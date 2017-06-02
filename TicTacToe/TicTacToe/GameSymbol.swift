//
//  GameSymbol.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation

enum GameSymbol {
    case X, O
    
    func name() -> String {
        switch self {
        case .X:
            return "x"
        default:
            return "o"
        }
    }
}
