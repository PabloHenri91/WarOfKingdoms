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
        
        self.player = Player(level: 1, xp: 0)
        
        
        self.addChild(self.gameWorld)
        self.gameWorld.addChild(self.gameCamera)
        self.gameCamera.node = self.player
        self.gameCamera.update()
        
        self.mapManager.reloadMap(position: self.player.position)
        self.gameWorld.addChild(self.mapManager)
        
        self.gameWorld.addChild(self.player)
        self.addChild(self.player.hud)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.mapManager.update(position: self.player.position)
        
        self.player.update()
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        
        self.gameCamera.update()
    }
    
    override func touchMoved(touch: UITouch) {
        super.touchMoved(touch: touch)
        
        if self.gameCamera.node == nil {
            self.gameCamera.position = self.gameCamera.position + touch.delta
        }
    }
    
    #if os(OSX)
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
            
        case 15: // r
            if let view = self.view {
                view.showsFPS = !view.showsFPS
                view.showsNodeCount = !view.showsNodeCount
                view.showsPhysics = !view.showsPhysics
            }
            break
            
        case 18, 19, 20, 21, 23, 22, 26, 28, 25, 29:
            self.player.keyDown(skillKeyCode: Skill.keyCode(rawValue: event.keyCode))
            break
            
        case 14: // e
            self.player.loadTextures()
            self.player.loadActions()
            break
            
        case 16: // y
            if self.gameCamera.node == nil {
                self.gameCamera.node = self.player
            } else {
                self.gameCamera.node = nil
            }
            break
            
        case 12: // q
            self.player.getXP(xp: Int.random(100))
            break
            
        case 0, 123: // a, ⬅️
            self.player.moveA = true
            break
            
        case 1, 125: // s, ⬇️
            self.player.moveS = true
            break
            
        case 2, 124: // d, ➡️
            self.player.moveD = true
            break
            
        case 13, 126: // w, ⬆️
            self.player.moveW = true
            break
            
        default:
            //print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            break
        }
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
            
        case 0, 123: // a, ⬅️
            self.player.moveA = false
            break
            
        case 1, 125: // s, ⬇️
            self.player.moveS = false
            break
            
        case 2, 124: // d, ➡️
            self.player.moveD = false
            break
            
        case 13, 126: // w, ⬆️
            self.player.moveW = false
            break
            
        default:
            //print("keyUp: \(event.characters!) keyCode: \(event.keyCode)")
            break
        }
    }
    
    #endif
}
