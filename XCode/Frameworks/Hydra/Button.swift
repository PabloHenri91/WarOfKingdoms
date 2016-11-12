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
        
        event = {
            print("touchUp " + name)
        }
        
        super.init(imageNamed: name, x: x, y: y, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchDown(touch: UITouch) {
        
        self.resetPosition()
        
        let duration:Double = 0.125
        
        let x = position.x + (size.width/2) * 0.05
        let y = position.y - (size.height/2) * 0.05
        
        self.run(SKAction.group([
            SKAction.scale(to: 0.95 , duration: duration),
            SKAction.move(to: CGPoint(x: x, y: y), duration: duration)
            ]))
    }
    
    func touchMoved(touch: UITouch) {
        
    }
    
    func touchUp(touch: UITouch) {
        
        let duration:Double = 0.125
        
        self.run(SKAction.group([
            SKAction.scale(to: 1.0 , duration: duration),
            SKAction.move(to: self.screenPosition(), duration: duration)
            ]))
        
        if let parent = self.parent {
            if self.contains(touch.location(in: parent)) {
                event()
            }
        }
    }
    
    #if os(OSX)
    
    override func mouseDown(with event: UITouch) {
        self.touchDown(touch: event)
    }
    
    override func mouseDragged(with event: UITouch) {
        self.touchMoved(touch: event)
        
    }
    
    override func mouseUp(with event: UITouch) {
        self.touchUp(touch: event)
    }
    
    #endif
}
