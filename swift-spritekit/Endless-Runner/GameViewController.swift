//
//  GameViewController.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as SKView
        if !skView.scene {
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsNodeCount = true
            
            // Create and configure the scene.
            let scene = MyScene(size: skView.bounds.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            // Present the scene.
            skView.presentScene(scene)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
