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
    
    enum horizontalAlignments: CGFloat {
        case left = 0
        case center = 1
        case right = 2
    }
    
    enum verticalAlignments: CGFloat {
        case top = 0
        case center = 1
        case bottom = 2
    }
    
    
    var verticalAlignment: verticalAlignments = .top
    var horizontalAlignment: horizontalAlignments = .left
    
    var sketchPosition: CGPoint = CGPoint.zero
    
    init() {
        super.init(texture: nil, color: SKColor.clear, size: CGSize(width: 1, height: 1))
    }
    
    init(imageNamed name: String, x: CGFloat, y: CGFloat,
         horizontalAlignment: horizontalAlignments = .left,
         verticalAlignment: verticalAlignments = .top) {
        
        let texture = SKTexture(imageNamed: name)
        texture.filteringMode = GameScene.defaultFilteringMode
        
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
    
    func contains(_ touch: UITouch) -> Bool {
        if self.isHidden {
            return false
        }
        if let parent = self.parent {
            return self.contains(touch.location(in: parent))
        }
        return false
    }
    
    func resetPosition() {
        self.position = CGPoint(
            x: self.sketchPosition.x + (GameScene.translate.dx * self.horizontalAlignment.rawValue),
            y: -self.sketchPosition.y + -(GameScene.translate.dy * self.verticalAlignment.rawValue)
        )
    }
    
    func screenPosition() -> CGPoint {
        return CGPoint(
            x: self.sketchPosition.x + (GameScene.translate.dx * self.horizontalAlignment.rawValue),
            y: -self.sketchPosition.y + -(GameScene.translate.dy * self.verticalAlignment.rawValue)
        )
    }
    
    override func removeFromParent() {
        
        for node in self.children {
            node.removeFromParent()
        }
        
        self.removeAllActions()
        self.removeAllChildren()
        super.removeFromParent()
        
        Control.set.remove(self)
    }
    
    
    static func resetPosition() {
        for control in Control.set {
            control.resetPosition()
        }
    }
}

extension SKNode {
    
    func destroy() {
        
        for node in self.children {
            node.destroy()
        }
        
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
    }
}
