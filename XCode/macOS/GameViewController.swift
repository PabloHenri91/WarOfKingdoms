//
//  GameViewController.swift
//  macOS
//
//  Created by Pablo Henrique Bertaco on 10/28/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController, NSWindowDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameScene.viewBoundsSize = self.view.bounds.size
        
        let scene = LoadScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.delegate = self
    }
    
    func windowDidResize(_ notification: Notification) {
        
        if let view = self.view as? SKView {
            if let scene = view.scene {
                GameScene.viewBoundsSize = self.view.bounds.size
                GameScene.updateSize()
                scene.size = GameScene.currentSize
            }
        }
    }
    
}

