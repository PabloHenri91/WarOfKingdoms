//
//  Tile.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Tile: SKNode {
    
    init(texture: SKTexture?, x: Int, y: Int) {
        
        super.init()
        self.position = CGPoint(x: x * Int(Chunk.tilewidth) - Int(Chunk.size.width)/2 + Int(Chunk.tilewidth/2),
                                y: -y * Int(Chunk.tileheight) + Int(Chunk.size.height)/2 - Int(Chunk.tileheight/2))
        
        let spriteNode = SKSpriteNode(texture: texture)
        self.addChild(spriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
