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
    
    init() {
        GameScene.defaultSize = CGSize(width: 568, height: 320)
        
        GameScene.defaultFilteringMode = .nearest
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func load() {
        super.load()
        
        #if DEBUG
//            self.view?.showsFPS = true
//            self.view?.showsNodeCount = true
//            self.view?.showsPhysics = true
        #endif
        
        self.addChild(Label(text: "LoadScene", x: 100, y: 100))
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
                self.view?.presentScene(MainMenuScene(), transition: GameScene.defaultTransition)
                break
            }
        }
    }
    
}
