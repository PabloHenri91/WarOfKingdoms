//
//  Player.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/5/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Player: Character {
    
    var hud: PlayerHUD
    
    var xp = 0
    
    init(level: Int, xp: Int) {
        
        self.hud = PlayerHUD(level: level, xp: xp)
        
        super.init()
        
        self.loadSkills()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func keyDown(skillKeyCode: Skill.keyCode?) {
        self.hud.boxPlayerSkills.keyDown(skillKeyCode: skillKeyCode)
    }
    
    func keyUp(skillKeyCode: Skill.keyCode?) {
        
    }
    
    func loadSkills() {
        self.skills.insert(Skill(caster: self, type: Skill.getType(name: Skill.typeName.lightningArrow)), at: 0)
        self.skills.insert(Skill(caster: self, type: Skill.getType(name: Skill.typeName.fireArrow)), at: 1)
        self.skills.insert(Skill(caster: self, type: Skill.getType(name: Skill.typeName.bowArt)), at: 2)
        
        self.hud.boxPlayerSkills.loadSkills(skills: self.skills)
    }
    
    func update() {
        
        self.move()
    }
    
    func getXP(xp: Int, position: CGPoint) {
        self.xp = self.xp + xp
        
        if let parent = self.parent {
            let label = Label(text: "+\(xp) xp", fontSize: Label.fontSize.fontSize8)
            label.addBorder()
            label.position = position + CGPoint(x: 0, y: 32)
            parent.addChild(label)
            
            let duration: TimeInterval = 1
            
            label.run(SKAction.move(by: CGVector(dx: 0, dy: 32), duration: duration))
            label.run(SKAction.sequence([
                SKAction.wait(forDuration: duration/2),
                SKAction.fadeAlpha(to: 0, duration: duration/2),
                SKAction.removeFromParent()
                ]
            ))
        }
        
        var levelUp = false
        while self.xp >= GameMath.xpForLevel(level: self.level + 1) {
            self.level = self.level + 1
            levelUp = true
        }
        
        if levelUp {
            self.levelUp()
        }
        
        self.hud.setXP(xp: self.xp)
    }
    
    func getXP(xp: Int) {
        self.getXP(xp: xp, position: self.position)
    }
    
    func levelUp() {
        self.hud.level = self.level
    }
}
