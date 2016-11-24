//
//  Spell.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/22/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Spell {
    
    var cost: CGFloat
    var magnitude: CGFloat
    var duration: Double
    
    var radius: CGFloat
    var angle: CGFloat
    
    var effect: effect?
    var weaponEffect: weaponEffect?
    
    enum effect {
        case water
        case lightning
        case life
        case arcane
        case shield
        case earth
        case cold
        case fire
    }
    
    enum weaponEffect {
        case fortifyPhysicalDamage
    }
    
    init(cost: CGFloat = 0, magnitude: CGFloat = 0, duration: Double = 0,
         radius: CGFloat = 0, angle: CGFloat = 0,
         effect: effect? = nil, weaponEffect: weaponEffect? = nil) {
        self.cost = cost
        self.magnitude = magnitude
        self.duration = duration
        self.radius = radius
        self.angle = angle
        self.effect = effect
        
        self.weaponEffect = weaponEffect
    }
}


