//
//  Uti.swift
//  TicTacToe
//
//  Created by Talita Lopes on 5/31/17.
//  Copyright © 2017 Onyo. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

extension Array {
    func randomIndex() -> Int {
        return Int(arc4random_uniform(UInt32(self.count)))
    }
    
    func randomItem() -> Element {
        return self[randomIndex()]
    }
    
    func shuffled() -> [Element] {
        return (self as NSArray).shuffled() as! [Element]
    }
    
}

extension UIColor {
    
    static func defaultTintColor() -> UIColor {
        return UIColor(red: 244/255.0, green: 139/255.0, blue: 148/255.0, alpha: 1.0)
    }
    
    static func winnerTintColor() -> UIColor {
        return UIColor(red: 43/255.0, green: 160/255.0, blue: 153/255.0, alpha: 1.0)
    }
    
}
