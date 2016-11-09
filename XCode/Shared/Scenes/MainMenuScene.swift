//
//  MainMenuScene.swift
//  Game
//
//  Created by Pablo Henrique Bertaco on 10/19/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class MainMenuScene: GameScene {
    
    enum states: String {
        case mainMenu
        case mission
    }
    
    var state: states = .mainMenu
    var nextState: states = .mainMenu
    
    
    var buttonPlay: Button!
    
    override func load() {
        super.load()
        
        self.buttonPlay = Button(imageNamed: "buttonYellow144x34", x: 212, y: 143, horizontalAlignment: .center, verticalAlignment: .center)
        self.buttonPlay.addChild(Label(text: "Play", x: buttonPlay.size.width/2, y: buttonPlay.size.height/2))
        
        
        self.addChild(Label(text: "MainMenuScene", x: 100, y: 100))
        
        self.addChild(self.buttonPlay)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if self.state == self.nextState {
            
            switch self.state {
                
            case .mainMenu:
                break
                
            case .mission:
                break
            }
        } else {
            self.state = self.nextState
            
            switch self.nextState {
                
            case .mainMenu:
                break
            case .mission:
                self.view?.presentScene(MissionScene(), transition: GameScene.defaultTransition)
                break
            }
        }
    }
    
    override func touchDown(touch: UITouch) {
        
    }
    
    override func touchMoved(touch: UITouch) {
        
    }
    
    override func touchUp(touch: UITouch) {
        if self.buttonPlay.contains(touch) {
            self.nextState = .mission
        }
    }
    
}
