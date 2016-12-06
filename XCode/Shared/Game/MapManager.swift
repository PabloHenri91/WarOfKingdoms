//
//  MapManager.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class MapManager: SKNode {
    
    
    var lastUpdate: TimeInterval = 0
    var loading = false
    
    var playerRegion = CGPoint.zero
    var loadedRegion = CGPoint.zero
    
    var chunks = [Chunk]()

    func reloadMap(position: CGPoint) {
        
        self.updatePlayerRegion(position: position)
        
        self.removeAllChildren()
        self.chunks.removeAll()
        
        for y in Int(self.playerRegion.y - 1)...Int(self.playerRegion.y + 1) {
            for x in Int(self.playerRegion.x - 1)...Int(self.playerRegion.x + 1) {
                let chunk = Chunk(x: x, y: -y)
                self.chunks.append(chunk)
                self.addChild(chunk)
            }
        }
        
        self.loadedRegion = self.playerRegion
    }
    
    func update(position: CGPoint) {
        
        if !self.loading {
            
            if GameScene.currentTime - self.lastUpdate > 0.1 {
                
                self.updatePlayerRegion(position: position)
                
                if self.playerRegion != self.loadedRegion {
                    self.loading = true
                    self.loadMap()
                    self.loading = false
                    self.lastUpdate = GameScene.currentTime
                } else {
                    for chunk in self.chunks {
                        for monster in chunk.monsters {
                            if monster.health <= 0 {
                                if GameScene.currentTime - monster.deathTime > 3.0 {
                                    monster.respawn()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updatePlayerRegion(position: CGPoint) {
        self.playerRegion.x = (position.x / Chunk.size.width).rounded()
        self.playerRegion.y = (position.y / Chunk.size.height).rounded()
    }
    
    func loadMap() {
        if self.playerRegion.x < self.loadedRegion.x {
            self.loadedRegion.x = self.loadedRegion.x - 1
            loadA()
            return
        }
        if self.playerRegion.y < self.loadedRegion.y {
            self.loadedRegion.y = self.loadedRegion.y - 1
            loadS()
            return
        }
        if self.playerRegion.x > self.loadedRegion.x {
            self.loadedRegion.x = self.loadedRegion.x + 1
            loadD()
            return
        }
        if self.playerRegion.y > self.loadedRegion.y {
            self.loadedRegion.y = self.loadedRegion.y + 1
            loadW()
            return
        }
    }
    
    func addChunks() {
        for chunk in self.chunks {
            if chunk.parent == nil {
                self.addChild(chunk)
            }
        }
    }
    
    func loadA() {
        self.chunks[2].destroy()
        self.chunks[5].destroy()
        self.chunks[8].destroy()
        
        self.chunks[2] = self.chunks[1]
        self.chunks[5] = self.chunks[4]
        self.chunks[8] = self.chunks[7]
        
        self.chunks[1] = self.chunks[0]
        self.chunks[4] = self.chunks[3]
        self.chunks[7] = self.chunks[6]
        
        self.chunks[0] = Chunk(x: Int(self.loadedRegion.x) - 1, y: Int(self.loadedRegion.y) + 1)
        self.chunks[3] = Chunk(x: Int(self.loadedRegion.x) - 1, y: Int(self.loadedRegion.y) + 0)
        self.chunks[6] = Chunk(x: Int(self.loadedRegion.x) - 1, y: Int(self.loadedRegion.y) - 1)
        
        addChunks()
    }
    
    func loadS() {
        self.chunks[0].destroy()
        self.chunks[1].destroy()
        self.chunks[2].destroy()
        
        self.chunks[0] = self.chunks[3]
        self.chunks[1] = self.chunks[4]
        self.chunks[2] = self.chunks[5]
        
        self.chunks[3] = self.chunks[6]
        self.chunks[4] = self.chunks[7]
        self.chunks[5] = self.chunks[8]
        
        self.chunks[6] = Chunk(x: Int(self.loadedRegion.x) - 1, y: Int(self.loadedRegion.y) - 1)
        self.chunks[7] = Chunk(x: Int(self.loadedRegion.x) + 0, y: Int(self.loadedRegion.y) - 1)
        self.chunks[8] = Chunk(x: Int(self.loadedRegion.x) + 1, y: Int(self.loadedRegion.y) - 1)
        
        addChunks()
    }
    
    func loadD() {
        self.chunks[0].destroy()
        self.chunks[3].destroy()
        self.chunks[6].destroy()
        
        self.chunks[0] = self.chunks[1]
        self.chunks[3] = self.chunks[4]
        self.chunks[6] = self.chunks[7]
        
        self.chunks[1] = self.chunks[2]
        self.chunks[4] = self.chunks[5]
        self.chunks[7] = self.chunks[8]
        
        self.chunks[2] = Chunk(x: Int(self.loadedRegion.x) + 1, y: Int(self.loadedRegion.y) + 1)
        self.chunks[5] = Chunk(x: Int(self.loadedRegion.x) + 1, y: Int(self.loadedRegion.y) + 0)
        self.chunks[8] = Chunk(x: Int(self.loadedRegion.x) + 1, y: Int(self.loadedRegion.y) - 1)
        
        addChunks()
    }
    
    func loadW() {
        self.chunks[6].destroy()
        self.chunks[7].destroy()
        self.chunks[8].destroy()
        
        self.chunks[6] = self.chunks[3]
        self.chunks[7] = self.chunks[4]
        self.chunks[8] = self.chunks[5]
        
        self.chunks[3] = self.chunks[0]
        self.chunks[4] = self.chunks[1]
        self.chunks[5] = self.chunks[2]
        
        self.chunks[0] = Chunk(x: Int(self.loadedRegion.x) - 1, y: Int(self.loadedRegion.y) + 1)
        self.chunks[1] = Chunk(x: Int(self.loadedRegion.x) + 0, y: Int(self.loadedRegion.y) + 1)
        self.chunks[2] = Chunk(x: Int(self.loadedRegion.x) + 1, y: Int(self.loadedRegion.y) + 1)
        
        addChunks()
    }
}
