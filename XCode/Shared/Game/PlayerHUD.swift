//
//  PlayerHUD.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/6/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class PlayerHUD: Control {
    
    private var labelLevel: Label
    
    var level: Int {
        get {
            return Int(self.labelLevel.text) ?? -1
        }
        set(newValue) {
            self.labelLevel.text = newValue.description
        }
    }
    
    var boxPlayerXP: BoxPlayerXP
    private var xp: Int
    var xpBarFill: Control
    
    var boxPlayerSkills: BoxPlayerSkills
    
    init(level: Int, xp: Int) {
        
        self.labelLevel = Label(text: "\(level)", fontSize: Label.fontSize.fontSize8, x: 17, y: 17)
        self.labelLevel.addShadow()
        
        self.xp = xp
        
        self.xpBarFill = Control(imageNamed: "xpBar8x34Fill", x: 7, y: 33)
        self.xpBarFill.zRotation = π
        
        self.boxPlayerXP = BoxPlayerXP()
        self.boxPlayerXP.isHidden = true
        
        self.boxPlayerSkills = BoxPlayerSkills()
        
        super.init(x: 0, y: 0)
        
        self.level = level
        
        let levelBackground = Button(imageNamed: "boxWhite34x34", x: 3, y: 3, horizontalAlignment: .left, verticalAlignment: .top)
        self.addChild(levelBackground)
        levelBackground.addChild(self.labelLevel)
        
        levelBackground.touchUpEvent = { [weak self] in
            guard let playerHUD = self else { return }
            playerHUD.boxPlayerXP.isHidden = !playerHUD.boxPlayerXP.isHidden
        }
        
        //
        let xpBarBackground = Control(imageNamed: "xpBar8x34Background", x: 37, y: 3, horizontalAlignment: .left, verticalAlignment: .top)
        self.addChild(xpBarBackground)
        
        xpBarBackground.addChild(self.xpBarFill)
        
        self.addChild(self.boxPlayerXP)
        
        self.setXP(xp: self.xp)
        
        self.addChild(self.boxPlayerSkills)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setXP(xp: Int) {
        self.xp = xp
        
        let xpForCurrentLevel = GameMath.xpForLevel(level: self.level)
        let xpForNextLevel = GameMath.xpForLevel(level: self.level + 1)
        
        
        let totalRequiredXP = CGFloat(xpForNextLevel - xpForCurrentLevel)
        let requiredXP = CGFloat(xpForNextLevel - self.xp)
        
        let progress = requiredXP / totalRequiredXP
        
        self.xpBarFill.yScale = 1 - progress
        
        self.boxPlayerXP.text = "\(Int(totalRequiredXP - requiredXP))/\(Int(totalRequiredXP))"
    }
    
}
