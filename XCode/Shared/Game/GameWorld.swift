//
//  GameWorld.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class GameWorld: SKNode {
    
    enum zPosition: CGFloat {
        case tileLayer0
        case tileLayer1
        case tileLayer2
        case character
        case player
        case tileLayer3
        case playerMoveArrow
        case getXPLabel
    }

    static func current() -> GameWorld? {
        return GameWorld.lastInstance
    }
    private static weak var lastInstance: GameWorld? = nil
    
    override init() {
        super.init()
        
        GameWorld.lastInstance = self
        //self.addChild(SKSpriteNode(imageNamed: "boxWhite64x64"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
