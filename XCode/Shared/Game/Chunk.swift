//
//  Chunk.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 11/2/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

class Chunk: SKNode, XMLParserDelegate {
    
    enum LayerNames: String {
        case base = "base"
        case walls = "walls"
        case decorationBottom = "decorationBottom"
        case decorationTop = "decorationTop"
    }
    
    static var width = 64
    static var height = 64
    static var tilewidth = 32
    static var tileheight = 32
    
    static var size: CGSize {
        get {
            return CGSize(width: Chunk.width * Chunk.tilewidth,
                          height: Chunk.height * Chunk.tileheight)
        }
    }
    
    var layerName = ""
    
    var tilesets = [Tileset]()
    
    init(x: Int, y: Int) {
        
        super.init()
        
        self.load(x: x, y: y)
        
        self.position = CGPoint(x: x * Int(Chunk.size.width),
                                y: y * Int(Chunk.size.height))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(x: Int, y: Int) {
        
        if let url = Bundle.main.url(forResource: "\(x).\(y)", withExtension: "tmx") {
            if let xmlParser = XMLParser(contentsOf: url) {
                xmlParser.delegate = self
                xmlParser.parse()
            }
        }
    }
    
    func loadLayer(data: [String]) {
        var i = data.makeIterator()
        for y in 0..<Chunk.height {
            for x in 0..<Chunk.width {
                if let id = Int(i.next()?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "") {
                    if id != 0 {
                        switch(id) {
                        default:
                            
                            var tilecount = 0
                            
                            for tileset in self.tilesets {
                                
                                let lastTilecount = tilecount
                                tilecount = tilecount + tileset.tilecount
                                
                                if id > lastTilecount && id <= tilecount {
                                    let texture = tileset.tileTextures[id - lastTilecount - 1]
                                    self.addChild(Tile(texture: texture, x: x, y: y))
                                    break
                                }
                            }
                            
                            break
                        }
                    }
                }
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
        case "map":
            Chunk.width = Int(attributeDict["width"]!)!
            Chunk.height = Int(attributeDict["height"]!)!
            Chunk.tilewidth = Int(attributeDict["tilewidth"]!)!
            Chunk.tileheight = Int(attributeDict["tileheight"]!)!
            break
        case "tileset":
            let tileset = Tileset()
            tileset.firstgid = Int(attributeDict["firstgid"]!)!
            tileset.name = (attributeDict["name"]!)
            tileset.tilewidth = CGFloat(Int(attributeDict["tilewidth"]!)!)
            tileset.tileheight = CGFloat(Int(attributeDict["tileheight"]!)!)
            tileset.tilecount = Int(attributeDict["tilecount"]!)!
            tileset.columns = Int(attributeDict["columns"]!)!
            tileset.load()
            self.tilesets.append(tileset)
            break
        case "image":
            break
        case "terraintypes":
            break
        case "terrain":
            break
        case "tile":
            break
        case "layer":
            self.layerName = attributeDict["name"]!
            break
        case "data":
            break
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let string = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.isEmpty == false {
            self.loadLayer(data: string.components(separatedBy: ","))
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parser.delegate = nil
    }
}