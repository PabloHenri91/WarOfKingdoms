//
//  Tile.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Tile: SKSpriteNode {
    
    init(texture: SKTexture, x: Int, y: Int, loadPhysics: Bool = false, zPosition: CGFloat? = nil) {
        
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        
        self.position = Tile.position(x: x, y: y)
        
        if let zPosition = zPosition {
            switch zPosition {
            case 0:
                self.zPosition = GameWorld.zPosition.tileLayer0.rawValue
            case 1:
                self.zPosition = GameWorld.zPosition.tileLayer1.rawValue
            case 2:
                self.zPosition = GameWorld.zPosition.tileLayer2.rawValue
            case 3:
                self.zPosition = GameWorld.zPosition.tileLayer3.rawValue
            default:
                break
            }
        }
        
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
    
    static func position(x: Int, y: Int) -> CGPoint {
        return CGPoint(x: x * Int(Chunk.tilewidth) - Int(Chunk.size.width)/2 + Int(Chunk.tilewidth/2),
                       y: -y * Int(Chunk.tileheight) + Int(Chunk.size.height)/2 - Int(Chunk.tileheight/2))
    }
    
    func loadPhysics() {
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody.usesPreciseCollisionDetection = false
        physicsBody.isDynamic = false
        
        self.physicsBody = physicsBody
    }
}
