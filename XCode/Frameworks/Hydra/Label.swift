//
//  Label.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 10/31/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Label: Control {
    
    enum fontSize: CGFloat {
        case fontSize8 = 8
        case fontSize16 = 16
        case fontSize24 = 24
        case fontSize32 = 32
    }
    
    var text: String {
        get {
            return self.labelNode.text ?? ""
        }
        set(newValue) {
            self.labelNode.text = newValue.translation()
        }
    }
    
    private var labelNode: SKLabelNode
    
    init(horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center,
         verticalAlignmentMode: SKLabelVerticalAlignmentMode = .center,
         fontName: String? = nil,
         text: String,
         fontSize: fontSize = .fontSize16,
         fontColor: SKColor = SKColor.black,
         x: CGFloat, y: CGFloat,
         horizontalAlignment: horizontalAlignments = .left,
         verticalAlignment: verticalAlignments = .top) {
        
        self.labelNode = SKLabelNode(text: fontName)
        
        self.labelNode.fontSize = fontSize.rawValue
        self.labelNode.fontColor = fontColor
        self.labelNode.horizontalAlignmentMode = horizontalAlignmentMode
        self.labelNode.verticalAlignmentMode = verticalAlignmentMode
        
        self.labelNode.text = text
        
        super.init()
        
        self.addChild(self.labelNode)
        
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
        if translated == self {
            //print(self)
        }
        return translated
    }
}
