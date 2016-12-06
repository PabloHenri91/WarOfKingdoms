//
//  Monster.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/26/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Monster: Character {
    
    static var monsterSet = Set<Monster>()
    
    
    // respawn
    var deathTime: TimeInterval = 0
    var spawnPoint = CGPoint.zero

    init(typeName: Monster.typeName) {
        
        let monsterType = Monster.getType(name: typeName)
        
        super.init(textureName: monsterType.name.rawValue)
        
        Monster.monsterSet.insert(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func update() {
        for monster in Monster.monsterSet {
            monster.update()
        }
    }
    
    override func update() {
        if self.health > 0 {
            self.move()
        }
    }
    
    override func move() {
        // TODO: func randomMove
        self.moveA = Int.random(100) < 1
        self.moveS = Int.random(100) < 1
        self.moveD = Int.random(100) < 1
        self.moveW = Int.random(100) < 1
        super.move()
    }
    
    func takeDamage(damage: Int, enemy: Character? = nil) {
        
        let duration: TimeInterval = 0.1
        
        if self.health > 0 && self.health - damage <= 0 {
            self.deathTime = GameScene.currentTime
            self.die()
        } else {
            self.health = self.health - damage
        }
        
        if damage > 0 {
            // TODO: damageEffect
            
            self.run(SKAction.sequence([
                SKAction.colorize(with: SKColor.red, colorBlendFactor: 1, duration: duration),
                SKAction.colorize(with: SKColor.white, colorBlendFactor: 1, duration: duration)
                ]))
        }
    }
    
    private func die() {
        
        self.removeAllActions()
        
        self.health = 0
        
        self.isMoving = false
        
        let duration: TimeInterval = 0.1
        
        self.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: duration),
                SKAction.fadeAlpha(to: 1, duration: duration)
                ])))
        
        self.afterDelay(1, runBlock: { [weak self] in
            self?.removeAllActions()
            self?.alpha = 0
            self?.physicsBody = nil
        })
    }
    
    func respawn() {
        
        self.loadPhysics()
        
        self.color = SKColor.white
        self.alpha = 1
        
        self.health = self.maxHealth
        self.position = self.spawnPoint
    }
    
    func touchDown(touch: UITouch) {
        if let parent = self.parent {
            if self.contains(touch.location(in: parent)) {
                self.takeDamage(damage: 1)
            }
        }
    }
    
    override func removeFromParent() {
        super.removeFromParent()
        Monster.monsterSet.remove(self)
    }

}

class MonsterType {
    var name: Monster.typeName
    
    init(name: Monster.typeName) {
        self.name = name
    }
}

extension Monster {
    
    enum typeName: String {
        case monster_bird1
        case monster_bird2
        case monster_bird3
        case monster_boar
        case monster_cacto
        case monster_dknight1
        case monster_dknight2
        case monster_elk
        case monster_golem1
        case monster_golem2
        case monster_lich
        case monster_lizardman1
        case monster_lizardman2
        case monster_minotaur
        case monster_phoenix
        case monster_raptor1
        case monster_raptor2
        case monster_treant
        case monster_wolf1
        case monster_wolf2
    }
    
    static func getType() -> MonsterType {
        return [MonsterType](Monster.types.values)[Int.random(Monster.types.count)]
    }
    
    static func getType(name: Monster.typeName) -> MonsterType {
        return Monster.types[name]!
    }
    
    private static var types = Monster.loadTypes()
    
    private static func loadTypes() -> [typeName: MonsterType] {
        
        var typeDictionary = [typeName: MonsterType]()
        var monsterTypeArray = [MonsterType]()
        
        //monsterTypeArray.append(MonsterType(name: .monster_bird1))
        //monsterTypeArray.append(MonsterType(name: .monster_bird2))
        //monsterTypeArray.append(MonsterType(name: .monster_bird3))
        monsterTypeArray.append(MonsterType(name: .monster_boar))
        monsterTypeArray.append(MonsterType(name: .monster_cacto))
        monsterTypeArray.append(MonsterType(name: .monster_dknight1))
        monsterTypeArray.append(MonsterType(name: .monster_dknight2))
        monsterTypeArray.append(MonsterType(name: .monster_elk))
        monsterTypeArray.append(MonsterType(name: .monster_golem1))
        monsterTypeArray.append(MonsterType(name: .monster_golem2))
        monsterTypeArray.append(MonsterType(name: .monster_lich))
        monsterTypeArray.append(MonsterType(name: .monster_lizardman1))
        monsterTypeArray.append(MonsterType(name: .monster_lizardman2))
        monsterTypeArray.append(MonsterType(name: .monster_minotaur))
        //monsterTypeArray.append(MonsterType(name: .monster_phoenix))
        monsterTypeArray.append(MonsterType(name: .monster_raptor1))
        monsterTypeArray.append(MonsterType(name: .monster_raptor2))
        monsterTypeArray.append(MonsterType(name: .monster_treant))
        monsterTypeArray.append(MonsterType(name: .monster_wolf1))
        monsterTypeArray.append(MonsterType(name: .monster_wolf2))
        
        for MonsterType in monsterTypeArray {
            typeDictionary.updateValue(MonsterType, forKey: MonsterType.name)
        }
        return typeDictionary
    }
}
