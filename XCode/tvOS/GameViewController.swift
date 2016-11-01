//
//  GameViewController.swift
//  tvOS
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
        
        #if DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
        #endif
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
