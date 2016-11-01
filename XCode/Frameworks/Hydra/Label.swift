//
//  Label.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 10/31/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Label: Control {
    
    var text: String {
        get {
            return self.labelNode.text ?? ""
        }
        set(newValue) {
            self.labelNode.text = newValue.translation()
        }
    }
    var labelNode: SKLabelNode
    
    init(horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center,
         verticalAlignmentMode: SKLabelVerticalAlignmentMode = .center,
         fontName: String? = nil,
         text: String = "",
         fontSize: CGFloat = 16,
         fontColor: SKColor = SKColor.black,
         x: CGFloat, y: CGFloat,
         horizontalAlignment: horizontalAlignment = .left,
         verticalAlignment: verticalAlignment = .top) {
        
        self.labelNode = SKLabelNode(text: fontName)
        
        self.labelNode.fontSize = 16
        self.labelNode.fontColor = fontColor
        self.labelNode.horizontalAlignmentMode = horizontalAlignmentMode
        self.labelNode.verticalAlignmentMode = verticalAlignmentMode
        
        self.labelNode.text = text
        
        super.init()
        
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

}

extension String {
    
    func translation() -> String {
        let translated = NSLocalizedString(self, comment: self)
//        if translated == self {
//            print(self)
//        }
        return translated
    }
}
