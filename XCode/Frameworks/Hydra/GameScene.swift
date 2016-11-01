//
//  GameScene.swift
//  Game
//
//  Created by Pablo Henrique Bertaco on 10/17/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import SpriteKit

#if os(watchOS)
    import WatchKit
    typealias SKColor = UIColor
#endif

class GameScene: SKScene {
    
    static let defaultSize = CGSize(width: 667, height: 375)
    
    static var viewBoundsSize = CGSize.zero
    static var sketchSize = CGSize.zero
    static var currentSize = CGSize.zero
    static var translate = CGVector.zero
    
    override init(size: CGSize = defaultSize) {
        
        Control.set = Set<Control>()
        
        GameScene.sketchSize = size
        GameScene.updateSize()
        
        super.init(size: GameScene.currentSize)
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.backgroundColor = GameColors.background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func updateSize() {
        
        let xScale = viewBoundsSize.width / sketchSize.width
        let yScale = viewBoundsSize.height / sketchSize.height
        let scale = min(xScale, yScale)
        
        currentSize.width = viewBoundsSize.width / scale
        currentSize.height = viewBoundsSize.height / scale
        
        translate.dx = (currentSize.width - sketchSize.width)/2
        translate.dy = (currentSize.height - sketchSize.height)/2
        
        print("currentSize")
        print(currentSize)
        
        print("translate")
        print(translate)
        
        Control.resetPosition()
    }
    
    func load() {
        self.scaleMode = SKSceneScaleMode.aspectFit
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.load()
    }
    #else
    override func didMove(to view: SKView) {
        self.load()
    }
    #endif
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.convert(pos, to: self)
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    #if os(iOS) || os(tvOS)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    #endif
    
    #if os(OSX)
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            break
        }
    }
    
    #endif
}
