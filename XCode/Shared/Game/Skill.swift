//
//  Skill.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/20/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Skill {
    
    // Skills
    enum keyCode: UInt16 {
        case key0 = 18
        case key1 = 19
        case key2 = 20
    }
    
    weak var caster: Character?
    
    var type: SkillType
    
    init(caster: Character, type: SkillType) {
        self.caster = caster
        self.type = type
    }
    
    func activate() {
        //guard let caster = caster else { return }
        print("activate \(self.type.name)")
    }
    
    func update() {
        
    }
    
    func cancel() {
        
    }
}

class SkillType {
    var name: Skill.typeName
    var cost: CGFloat
    var targetType: Skill.targetType
    var cooldown: Double
    var spells: [Spell]
    
    init(name: Skill.typeName, cost: CGFloat, targetType: Skill.targetType, cooldown: Double, spells: [Spell]) {
        self.name = name
        self.cost = cost
        self.targetType = targetType
        self.cooldown = cooldown
        self.spells = spells
    }
}

extension Skill {
    
    enum typeName: String {
        case heal
        case fireBall
        case lightningArrow
        case fireArrow
        case bowArt
    }
    
    enum targetType {
        case onSelf
        case onTarget
        case onWeapon
    }
    
    static func getType(name: Skill.typeName) -> SkillType {
        return Skill.types[name]!
    }
    
    private static var types = Skill.loadTypes()
    
    private static func loadTypes() -> [typeName: SkillType] {
        
        var typeDictionary = [typeName: SkillType]()
        var skillTypeArray = [SkillType]()
        
        
        skillTypeArray.append(
            SkillType(name: .heal, cost: 1, targetType: .onSelf, cooldown: 1, spells: [
                Spell(magnitude: 2, effect: .life)
                ]))
        
        skillTypeArray.append(
            SkillType(name: .fireBall, cost: 1, targetType: .onTarget, cooldown: 1, spells: [
                Spell(magnitude: 2, radius: 32, effect: .fire)
                ]))
        
        skillTypeArray.append(
            SkillType(name: .lightningArrow, cost: 1, targetType: .onWeapon, cooldown: 1, spells: [
                Spell(magnitude: 2, effect: .lightning)
                ]))
        
        skillTypeArray.append(
            SkillType(name: .fireArrow, cost: 1, targetType: .onWeapon, cooldown: 1, spells: [
                Spell(magnitude: 2, effect: .fire),
                Spell(magnitude: 2, duration: 3, effect: .fire)
                ]))
        
        skillTypeArray.append(
            SkillType(name: .bowArt, cost: 1, targetType: .onSelf, cooldown: 1, spells: [
                Spell(magnitude: 2, duration: 5, weaponEffect: .fortifyPhysicalDamage)
                ]))
        
        
        for skillType in skillTypeArray {
            typeDictionary.updateValue(skillType, forKey: skillType.name)
        }
        return typeDictionary
    }
}
