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
    
    
    var buttonPlay: Button
    
    override init(size: CGSize = defaultSize) {
        
        self.buttonPlay = Button(imageNamed: "buttonYellow144x34", x: 200, y: 200)
        self.buttonPlay.addChild(Label(text: "Play", x: buttonPlay.size.width/2, y: buttonPlay.size.height/2))
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func load() {
        super.load()
        
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
