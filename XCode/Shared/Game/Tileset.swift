//
//  Tileset.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/5/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Tileset {
    
    var firstgid: Int = 0
    var name: String = ""
    var tilewidth: CGFloat = 0
    var tileheight: CGFloat = 0
    var tilecount: Int = 0
    var columns: Int = 0
    
    var tileTextures = [SKTexture]()
    
    func load() {
        
        let texture = SKTexture(imageNamed: self.name)
        texture.filteringMode = GameScene.defaultFilteringMode
        let size = texture.size()
        
        var column: CGFloat = 0
        var row: CGFloat = 1
        
        for _ in 0..<self.tilecount {
            
            if Int(column) >= self.columns {
                column = 0
                row = row + 1
            }
            
            let rect = CGRect(
                origin: CGPoint(x: (tilewidth * column)/size.width, y: (size.height - (tileheight * row))/size.height),
                size: CGSize(width: tilewidth/size.width, height: tileheight/size.height))
            
            let tileTexture = SKTexture(rect: rect, in: texture)
            tileTexture.filteringMode = GameScene.defaultFilteringMode
            
            self.tileTextures.append(tileTexture)
            
            
            column = column + 1
        }
    }
}
