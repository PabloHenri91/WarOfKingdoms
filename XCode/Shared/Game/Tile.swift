//
//  Tile.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Tile: SKSpriteNode {
    
    init(texture: SKTexture, x: Int, y: Int, loadPhysics: Bool = false) {
        
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        
        self.position = CGPoint(x: x * Int(Chunk.tilewidth) - Int(Chunk.size.width)/2 + Int(Chunk.tilewidth/2),
                                y: -y * Int(Chunk.tileheight) + Int(Chunk.size.height)/2 - Int(Chunk.tileheight/2))
        
//        let debugSpriteNode = SKSpriteNode(imageNamed: "boxWhite32x32")
//        debugSpriteNode.size = spriteNode.size
//        debugSpriteNode.alpha = 0.5
//        self.addChild(debugSpriteNode)
        
        if loadPhysics {
            self.loadPhysics()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadPhysics() {
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody.usesPreciseCollisionDetection = false
        physicsBody.isDynamic = false
        
        self.physicsBody = physicsBody
    }
}
