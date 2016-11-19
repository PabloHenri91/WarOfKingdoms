//
//  Player.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/5/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var hud: PlayerHUD
    
    var level = 1
    var xp = 0
    
    // Movement
    var isMoving = false
    
    enum moveType {
        case moveA
        case moveS
        case moveD
        case moveW
    }
    
    var lastMove: moveType = .moveA
    
    // Controls
    var moveA = false
    var moveS = false
    var moveD = false
    var moveW = false
    
    init() {
        
        self.hud = PlayerHUD(level: self.level, xp: self.xp)
        
        let texture = SKTexture(imageNamed: "boxWhite32x32")
        texture.filteringMode = GameScene.defaultFilteringMode
        
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        
        self.position = CGPoint(x: Chunk.tilewidth/2, y: Chunk.tileheight/2)
        
        self.loadPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadPhysics() {
        
        var transform = CGAffineTransform(rotationAngle: π/4)
        
        let physicsBody = SKPhysicsBody(polygonFrom: CGPath(rect: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height), transform: &transform))
        
        physicsBody.usesPreciseCollisionDetection = false
        physicsBody.collisionBitMask = 0
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = true
        
        self.physicsBody = physicsBody
    }
    
    func update() {
        
        self.move()
    }
    
    func move() {
        
        if self.isMoving {
            return
        }
        
        let moveActionDuration: TimeInterval = 1/60 * 5
        
        var moveDirectionX: CGFloat = 0
        var moveDirectionY: CGFloat = 0
        
        if self.moveA {
            moveDirectionX = moveDirectionX - 1
        }
        if self.moveS {
            moveDirectionY = moveDirectionY - 1
        }
        if self.moveD {
            moveDirectionX = moveDirectionX + 1
        }
        if self.moveW {
            moveDirectionY = moveDirectionY + 1
        }
        
        if let contactedBodies = self.physicsBody?.allContactedBodies() {
            for physicsBody in contactedBodies {
                if let node = physicsBody.node {
                    
                    let delta = node.position - self.position
                    
                    if delta.x > Chunk.tilewidth/2 {
                        if moveDirectionX > 0 {
                            moveDirectionX = 0
                        }
                    }
                    
                    if delta.x < -Chunk.tilewidth/2 {
                        if moveDirectionX < 0 {
                            moveDirectionX = 0
                        }
                    }
                    
                    if delta.y > Chunk.tileheight/2 {
                        if moveDirectionY > 0 {
                            moveDirectionY = 0
                        }
                    }
                    
                    if delta.y < -Chunk.tileheight/2 {
                        if moveDirectionY < 0 {
                            moveDirectionY = 0
                        }
                    }
                }
            }
        }
        
        
        if moveDirectionX != 0 && moveDirectionY != 0 {
            switch self.lastMove {
            case .moveA, .moveD:
                moveDirectionX = 0
                break
            case .moveS, .moveW:
                moveDirectionY = 0
                break
            }
        }
        
        if moveDirectionX != 0 {
            self.isMoving = true
            
            if moveDirectionX > 0 {
                self.lastMove = .moveD
            } else {
                self.lastMove = .moveA
            }
            
            self.run(SKAction.sequence(
                [
                    SKAction.moveBy(x: moveDirectionX * Chunk.tilewidth, y: 0, duration: moveActionDuration),
                    SKAction.run { [weak self] in
                        self?.isMoving = false
                    }
                ]
            ))
            
        } else {
            if moveDirectionY != 0 {
                self.isMoving = true
                
                if moveDirectionY > 0 {
                    self.lastMove = .moveW
                } else {
                    self.lastMove = .moveS
                }
                
                self.run(SKAction.sequence(
                    [
                        SKAction.moveBy(x: 0, y: moveDirectionY * Chunk.tileheight, duration: moveActionDuration),
                        SKAction.run { [weak self] in
                            self?.isMoving = false
                        }
                    ]
                ))
            }
        }
    }
    
    func getXP(xp: Int, position: CGPoint) {
        self.xp = self.xp + xp
        
        if let parent = self.parent {
            let label = Label(text: "+\(xp) xp", fontSize: Label.fontSize.fontSize8)
            label.addBorder()
            label.position = position + CGPoint(x: 0, y: 32)
            parent.addChild(label)
            
            let duration: TimeInterval = 1
            
            label.run(SKAction.move(by: CGVector(dx: 0, dy: 32), duration: duration))
            label.run(SKAction.sequence([
                SKAction.wait(forDuration: duration/2),
                SKAction.fadeAlpha(to: 0, duration: duration/2),
                SKAction.removeFromParent()
                ]
            ))
        }
        
        var levelUp = false
        while self.xp >= GameMath.xpForLevel(level: self.level + 1) {
            self.level = self.level + 1
            levelUp = true
        }
        
        if levelUp {
            self.levelUp()
        }
        
        self.hud.setXP(xp: self.xp)
    }
    
    func getXP(xp: Int) {
        self.getXP(xp: xp, position: self.position)
    }
    
    func levelUp() {
        self.hud.level = self.level
    }
}

extension Player {
    
}
