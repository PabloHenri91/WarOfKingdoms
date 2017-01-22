//
//  SkillButton.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/21/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class SkillButton: Button {
    
    weak var skill: Skill?
    
    init(x: CGFloat, y: CGFloat,
         horizontalAlignment: horizontalAlignment = .left,
         verticalAlignment: verticalAlignment = .top) {
        
        super.init(imageNamed: "boxWhite34x34", x: x, y: y, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
        
        self.touchUpEvent = { [weak self] in
            guard let skillButton = self else { return }
            
            skillButton.skill?.activate()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
