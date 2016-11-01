//
//  LoadScene.swift
//  Game
//
//  Created by Pablo Henrique Bertaco on 10/17/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class LoadScene: GameScene {
    
    enum state: String {
        case load
        case mainMenu
    }
    
    var state: state = .load
    var nextState: state = .load
    
    override func load() {
        super.load()
        
        self.addBackground()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if self.state == self.nextState {
            
            switch self.state {
                
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
                self.view?.presentScene(MainMenu(), transition: SKTransition.crossFade(withDuration: 0.25))
                break
            }
        }
    }
    
    func addBackground() {
        
    }
}
