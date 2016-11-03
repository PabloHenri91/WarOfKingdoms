//
//  MissionScene.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class MissionScene: GameScene {

    var gameWorld: GameWorld
    var gameCamera: GameCamera
    
    var mapManager: MapManager
    
    override init(size: CGSize = defaultSize) {
        
        self.gameWorld = GameWorld()
        self.gameCamera = GameCamera()
        
        self.mapManager = MapManager()
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func load() {
        super.load()
        
        self.addChild(self.gameWorld)
        self.gameWorld.addChild(self.gameCamera)
        self.gameWorld.addChild(self.gameCamera.node)
        self.gameCamera.update()
        
        self.mapManager.reloadMap(position: CGPoint.zero)
        self.gameWorld.addChild(self.mapManager)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        self.mapManager.update(position: gameCamera.node.position)
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        
        self.gameCamera.update()
    }
    
    override func touchMoved(touch: UITouch) {
        self.gameCamera.node.position = self.gameCamera.node.position + CGPoint(x: touch.deltaX, y: touch.deltaY)
    }
}
