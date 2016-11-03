//
//  LoadScene.swift
//  Game
//
//  Created by Pablo Henrique Bertaco on 10/17/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class LoadScene: GameScene {
    
    enum states: String {
        case load
        case mainMenu
    }
    
    var state: states = .load
    var nextState: states = .load
    
    override func load() {
        super.load()
        
        self.addChild(Label(text: "LoadScene", x: 100, y: 100))
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if self.state == self.nextState {
            
            switch state {
                
            case .load:
                self.nextState = .mainMenu
                break
                
            case .mainMenu:
                break
            }
        } else {
            self.state = self.nextState
            
            switch self.nextState {
                
            case .load:
                break
                
            case .mainMenu:
                self.view?.presentScene(MainMenuScene(), transition: GameScene.defaultTransition)
                break
            }
        }
    }
    
}
