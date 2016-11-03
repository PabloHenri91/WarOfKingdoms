//
//  Chunk.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Chunk: SKNode {
    
    static var size: CGFloat = 64
    
    init(x: Int, y: Int) {
        super.init()
        self.position = CGPoint(x: x * Int(Chunk.size), y: y * Int(Chunk.size))
        self.addChild(SKSpriteNode(imageNamed: "boxWhite64x64"))
        self.addChild(Label(text: "\(x) \(y)", x: 0, y: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
