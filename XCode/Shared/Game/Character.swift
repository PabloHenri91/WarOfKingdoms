//
//  Character.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/24/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Character: SKSpriteNode {
    
    var level = 1
    
    // Movement
    var actionMoveA = SKAction()
    var actionMoveS = SKAction()
    var actionMoveD = SKAction()
    var actionMoveW = SKAction()
    
    var isMoving = false
    
    enum moveType {
        case moveA
        case moveS
        case moveD
        case moveW
    }
    
    var lastMove: moveType = .moveS
    
    // Controls
    var moveA = false
    var moveS = false
    var moveD = false
    var moveW = false
    
    // Textures
    var texturesA = [SKTexture]()
    var texturesS = [SKTexture]()
    var texturesD = [SKTexture]()
    var texturesW = [SKTexture]()
    
    var texturesMoveA = [SKTexture]()
    var texturesMoveS = [SKTexture]()
    var texturesMoveD = [SKTexture]()
    var texturesMoveW = [SKTexture]()
    
    // Skills
    var target: Player?
    var skills = [Skill?](repeating: nil, count: 3)
    
    
    init() {
        
        let texture = SKTexture(imageNamed: "boxWhite32x32")
        texture.filteringMode = GameScene.defaultFilteringMode
        
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        
        self.position = CGPoint(x: Chunk.tilewidth/2, y: Chunk.tileheight/2)
        
        self.loadPhysics()
        
        self.loadTextures()//(name: "charaTeste")
        self.loadActions()
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
    
    func loadActions() {
        
        let speed: Double = 64
        let distance: Double = Double(Chunk.tilewidth)
        
        let moveActionDuration: TimeInterval = distance/speed
        
        self.actionMoveA = SKAction.group([
            SKAction.sequence([
                SKAction.animate(with: self.texturesMoveA, timePerFrame: moveActionDuration/Double(self.texturesMoveA.count), resize: false, restore: false),
                SKAction.animate(with: self.texturesA, timePerFrame: moveActionDuration/Double(self.texturesA.count), resize: false, restore: false)
                ]),
            SKAction.sequence([
                SKAction.moveBy(x: -1 * Chunk.tilewidth, y: 0, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
                ])
            ])
        
        self.actionMoveS = SKAction.group([
            SKAction.sequence([
                SKAction.animate(with: self.texturesMoveS, timePerFrame: moveActionDuration/Double(self.texturesMoveS.count)),
                SKAction.animate(with: self.texturesS, timePerFrame: moveActionDuration/Double(self.texturesS.count))
                ]),
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: -1 * Chunk.tileheight, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
                ])
            ])
        
        self.actionMoveD = SKAction.group([
            SKAction.sequence([
                SKAction.animate(with: self.texturesMoveD, timePerFrame: moveActionDuration/Double(self.texturesMoveD.count)),
                SKAction.animate(with: self.texturesD, timePerFrame: moveActionDuration/Double(self.texturesD.count))
                ]),
            SKAction.sequence([
                SKAction.moveBy(x: 1 * Chunk.tilewidth, y: 0, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
                ])
            ])
        
        self.actionMoveW = SKAction.group([
            SKAction.sequence([
                SKAction.animate(with: self.texturesMoveW, timePerFrame: moveActionDuration/Double(self.texturesMoveW.count)),
                SKAction.animate(with: self.texturesW, timePerFrame: moveActionDuration/Double(self.texturesW.count))
                ]),
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: 1 * Chunk.tileheight, duration: moveActionDuration),
                SKAction.run { [weak self] in
                    self?.isMoving = false
                }
                ])
            ])
    }
    
    func loadTextures(name: String = "chara\(1 + Int.random(8))\(1 + Int.random(8))") {
        
        self.texturesA = [SKTexture]()
        self.texturesS = [SKTexture]()
        self.texturesD = [SKTexture]()
        self.texturesW = [SKTexture]()
        
        self.texturesMoveA = [SKTexture]()
        self.texturesMoveS = [SKTexture]()
        self.texturesMoveD = [SKTexture]()
        self.texturesMoveW = [SKTexture]()
        
        let tileset = Tileset()
        tileset.tilewidth = 26
        tileset.tileheight = 36
        tileset.columns = 3
        tileset.tilecount = 12
        
        tileset.name = name
        tileset.load()
        
        self.texture = tileset.tileTextures[1] // S
        self.size = self.texture!.size()
        
        self.anchorPoint.y = 1 - (self.size.height/32)/2
        
        self.texturesA.append(tileset.tileTextures[4])
        self.texturesS.append(tileset.tileTextures[1])
        self.texturesD.append(tileset.tileTextures[7])
        self.texturesW.append(tileset.tileTextures[10])
        
        
        self.texturesMoveA += [
            tileset.tileTextures[5],
            tileset.tileTextures[4],
            tileset.tileTextures[3],
            tileset.tileTextures[4]
        ]
        
        self.texturesMoveS += [
            tileset.tileTextures[2],
            tileset.tileTextures[1],
            tileset.tileTextures[0],
            tileset.tileTextures[1]
        ]
        self.texturesMoveD += [
            
            tileset.tileTextures[8],
            tileset.tileTextures[7],
            tileset.tileTextures[6],
            tileset.tileTextures[7]
        ]
        
        self.texturesMoveW += [
            tileset.tileTextures[11],
            tileset.tileTextures[10],
            tileset.tileTextures[9],
            tileset.tileTextures[10]
        ]
    }
    
    func move() {
        
        if self.isMoving {
            return
        }
        
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
                self.run(self.actionMoveD)
            } else {
                self.lastMove = .moveA
                self.run(self.actionMoveA)
            }
            
        } else {
            if moveDirectionY != 0 {
                self.isMoving = true
                
                if moveDirectionY > 0 {
                    self.lastMove = .moveW
                    self.run(self.actionMoveW)
                } else {
                    self.lastMove = .moveS
                    self.run(self.actionMoveS)
                }
            }
        }
    }
    
}
