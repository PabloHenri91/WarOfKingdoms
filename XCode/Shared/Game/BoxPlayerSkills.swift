//
//  BoxPlayerSkills.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/20/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class BoxPlayerSkills: Control {
    
    var skillButtons = [SkillButton]()
    
    init() {
        
        super.init(x: 0, y: 0)
        
        let button1 = SkillButton(imageNamed: "boxWhite34x34", x: 230, y: 283, horizontalAlignment: .center, verticalAlignment: .bottom)
        self.skillButtons.append(button1)
        
        let button2 = SkillButton(imageNamed: "boxWhite34x34", x: 267, y: 283, horizontalAlignment: .center, verticalAlignment: .bottom)
        self.skillButtons.append(button2)
        
        let button3 = SkillButton(imageNamed: "boxWhite34x34", x: 304, y: 283, horizontalAlignment: .center, verticalAlignment: .bottom)
        self.skillButtons.append(button3)
        
        for button in self.skillButtons {
            self.addChild(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func keyDown(skillKeyCode: Skill.keyCode?, caster: Player?, target: Player?) {
        
        var keyIndex: Int?
        
        if let skillKeyCode = skillKeyCode {
            switch skillKeyCode {
            case .key0:
                keyIndex = 0
                break
            case .key1:
                keyIndex = 1
                break
            case .key2:
                keyIndex = 2
                break
            }
            
            if let keyIndex = keyIndex {
                if keyIndex < self.skillButtons.count {
                    self.skillButtons[keyIndex].skill?.keyDown(caster: caster, target: target)
                }
            }
        }
    }
    
    func keyUp(skillKeyCode: Skill.keyCode?) {
        
    }
    
}
