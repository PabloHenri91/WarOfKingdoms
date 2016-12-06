//
//  Tileset.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/5/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Tileset: SKSpriteNode {
    
    private var tilewidth: CGFloat = 0
    private var tileheight: CGFloat = 0
    private var columns: Int = 0
    private var rows: Int = 0
    private var tilecount: Int = 0
    
    var tileTextures = [SKTexture]()
    
    init(imageNamed name: String) {
        let texture = SKTexture(imageNamed: name)
        texture.filteringMode = GameScene.defaultFilteringMode
        
        
        super.init(texture: texture, color: SKColor.white, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(tilewidth: Int, tileheight: Int) {
        self.tilewidth = CGFloat(tilewidth)
        self.tileheight = CGFloat(tileheight)
        
        self.columns = Int(self.size.width / self.tilewidth)
        self.rows = Int(self.size.height / self.tileheight)
        
        self.tilecount = self.columns * self.rows
        
        self.load()
    }
    
    func load(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        self.tilewidth = self.size.width / CGFloat(columns)
        self.tileheight = self.size.height / CGFloat(rows)
        
        self.tilecount = self.columns * self.rows
        
        self.load()
    }
    
    private func load() {
        
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
            
            let tileTexture = SKTexture(rect: rect, in: self.texture!)
            tileTexture.filteringMode = GameScene.defaultFilteringMode
            
            self.tileTextures.append(tileTexture)
            
            
            column = column + 1
        }
    }
}
