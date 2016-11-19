//
//  GameViewController.swift
//  GameV
//
//  Created by Pablo Henrique Bertaco on 10/28/16.
//  Copyright © 2016 PabloHenri91. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameScene.viewBoundsSize = self.view.bounds.size
        
        let scene = LoadScene()

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let view = self.view as? SKView {
            if let scene = view.scene {
                GameScene.viewBoundsSize = self.view.bounds.size
                GameScene.updateSize()
                scene.size = GameScene.currentSize
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
