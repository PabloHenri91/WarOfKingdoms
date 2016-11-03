//
//  Button.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Button: Control {
    
    var event: () -> Void
    
    override init(imageNamed name: String, x: CGFloat, y: CGFloat,
                  horizontalAlignment: horizontalAlignments = .left,
                  verticalAlignment: verticalAlignments = .top) {
        
        event = {}
        
        super.init(imageNamed: name, x: x, y: y, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func touchDown(atPoint pos : CGPoint) {
        
        resetPosition()
        
        let duration:Double = 0.125
        
        let x = position.x + (size.width/2) * 0.05
        let y = position.y - (size.height/2) * 0.05
        
        run(SKAction.group([
            SKAction.scale(to: 0.95 , duration: duration),
            SKAction.move(to: CGPoint(x: x, y: y), duration: duration)
            ]))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        let duration:Double = 0.125
        
        run(SKAction.group([
            SKAction.scale(to: 1.0 , duration: duration),
            SKAction.move(to: screenPosition(), duration: duration)
            ]))
        
        if contains(pos) {
            event()
        }
    }
}
