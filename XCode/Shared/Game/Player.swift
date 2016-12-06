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
        
        super.init(textureName: "chara\(1 + Int.random(8))\(1 + Int.random(8))")
        
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
    
    override func update() {
        
        self.move()
    }
    
    override func move() {
        if let destination = self.destination {
            
            self.moveA = false
            self.moveS = false
            self.moveD = false
            self.moveW = false
            
            if self.position.distanceTo(destination) < 1 {
                self.destination = nil
            } else {
                let delta = destination - self.position
                
                if abs(delta.x) > 16 {
                    if delta.x > 0 {
                        self.moveD = true
                    } else {
                        self.moveA = true
                    }
                }
                
                if abs(delta.y) > 16 {
                    if delta.y > 0 {
                        self.moveW = true
                    } else {
                        self.moveS = true
                    }
                }
            }
        }
        
        super.move()
    }
    
    func touchDown(touch: UITouch) {
        if let parent = self.parent {
            var touchLocation = touch.location(in: parent)
            
            self.moveA = false
            self.moveS = false
            self.moveD = false
            self.moveW = false
            
            if self.contains(touchLocation) {
                self.destination = nil
            } else {
                touchLocation = CGPoint(
                    x: ((touchLocation.x - Chunk.tilewidth/2) / Chunk.tilewidth).rounded() * Chunk.tilewidth + Chunk.tilewidth/2,
                    y: ((touchLocation.y - Chunk.tileheight/2) / Chunk.tileheight).rounded() * Chunk.tileheight + Chunk.tileheight/2)
                
                self.destination = touchLocation
                self.setMoveArrowToPoint(point: touchLocation)
            }
        }
    }
    
    private func setMoveArrowToPoint(point: CGPoint) {
        guard let parent = self.parent else { return }
        
        let control = Control(imageNamed: "playerDestinationArrow", x: 0, y: 0)
        control.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        control.position = point
        parent.addChild(control)
        control.zPosition = GameWorld.zPosition.playerMoveArrow.rawValue
        
        
        let duration: TimeInterval = 0.5
        
        control.run(SKAction.scale(to: 0, duration: duration))
        
        control.run(SKAction.sequence([
            SKAction.wait(forDuration: duration/2),
            SKAction.fadeAlpha(to: 0, duration: duration/2),
            SKAction.removeFromParent()
            ]))
        
    }
    
    func getXP(xp: Int, position: CGPoint) {
        self.xp = self.xp + xp
        
        if let parent = self.parent {
            let label = Label(text: "+\(xp) xp", fontSize: Label.fontSize.fontSize8)
            label.addBorder()
            label.position = position + CGPoint(x: 0, y: 32)
            parent.addChild(label)
            label.zPosition = GameWorld.zPosition.getXPLabel.rawValue
            
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

class PlayerType {
    var name: Player.typeName
    
    init(name: Player.typeName) {
        self.name = name
    }
}

extension Player {
    
    enum typeName: String {
        case archer
        case barbarian
    }
    
    static func getType(name: Player.typeName) -> PlayerType {
        return Player.types[name]!
    }
    
    private static var types = Player.loadTypes()
    
    private static func loadTypes() -> [typeName: PlayerType] {
        
        var typeDictionary = [typeName: PlayerType]()
        var monsterTypeArray = [PlayerType]()
        
        
        monsterTypeArray.append(PlayerType(name: .archer))
        monsterTypeArray.append(PlayerType(name: .barbarian))
        
        
        for PlayerType in monsterTypeArray {
            typeDictionary.updateValue(PlayerType, forKey: PlayerType.name)
        }
        return typeDictionary
    }
}
