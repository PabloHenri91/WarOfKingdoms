//
//  Control.swift
//  Game
//
//  Created by Pablo Henrique Bertaco on 10/18/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Control: SKSpriteNode {
    
    static var set = Set<Control>()
    
    enum horizontalAlignment: CGFloat {
        case left = 0
        case center = 1
        case right = 2
    }
    
    enum verticalAlignment: CGFloat {
        case top = 0
        case center = 1
        case bottom = 2
    }
    
    
    var verticalAlignment: verticalAlignment = .top
    var horizontalAlignment: horizontalAlignment = .left
    
    var sketchPosition: CGPoint = CGPoint.zero
    
    init() {
        super.init(texture: nil, color: SKColor.clear, size: CGSize(width: 1, height: 1))
    }
    
    init(imageNamed name: String, x: CGFloat, y: CGFloat,
         horizontalAlignment: horizontalAlignment = .left,
         verticalAlignment: verticalAlignment = .top) {
        
        let texture = SKTexture(imageNamed: name)
        
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.sketchPosition = CGPoint(x: x, y: y)
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        
        self.resetPosition()
        
        Control.set.insert(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetPosition() {
        self.position = CGPoint(
            x: self.sketchPosition.x + (GameScene.translate.dx * self.horizontalAlignment.rawValue),
            y: -self.sketchPosition.y + -(GameScene.translate.dy * self.verticalAlignment.rawValue)
        )
    }
    
    override func removeFromParent() {
        super.removeFromParent()
        Control.set.remove(self)
    }
    
    
    static func resetPosition() {
        for control in Control.set {
            control.resetPosition()
        }
    }
}
