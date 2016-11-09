//
//  GameMath.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/5/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import CoreGraphics

class GameMath {
    
    static func xpForLevel(level x: Int) -> Int {
        let x = Double(x - 1)
        let xp = pow(0.02 * x, 3) + pow(3.0 * x, 2) + 100.0 * x
        return Int(xp)
    }

}
