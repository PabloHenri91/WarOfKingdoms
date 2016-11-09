//
//  MissionScene.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class MissionScene: GameScene {

    var gameWorld: GameWorld!
    var gameCamera: GameCamera!
    
    var mapManager: MapManager!
    
    var player: Player!
    
    override func load() {
        super.load()
        
        self.gameWorld = GameWorld()
        self.gameCamera = GameCamera()
        
        self.mapManager = MapManager()
        
        self.player = Player()
        
        
        self.addChild(self.gameWorld)
        self.gameWorld.addChild(self.gameCamera)
        self.gameWorld.addChild(self.gameCamera.node)
        self.gameCamera.update()
        
        self.mapManager.reloadMap(position: self.player.position)
        self.gameWorld.addChild(self.mapManager)
        
        self.gameWorld.addChild(self.player)
        self.addChild(self.player.hud)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.mapManager.update(position: self.player.position)
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        
        self.gameCamera.node.position = self.player.position
        self.gameCamera.update()
    }
    
    override func touchMoved(touch: UITouch) {
        super.touchMoved(touch: touch)
        
        self.player.position = self.player.position + touch.delta
    }
    
    #if os(OSX)
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
            
        case 12: // q
            self.player.getXP(xp: Int.random(100))
            break
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            break
        }
    }
    #endif
}
