//
//  GameWorld.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class GameWorld: SKNode {

    
    override init() {
        super.init()
        //self.addChild(SKSpriteNode(imageNamed: "boxWhite64x64"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
