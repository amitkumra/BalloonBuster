//
//  GameViewController.swift
//  BalloonBuster
//
//  Created by Amit on 2024-01-15.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let view = self.view as! SKView? {
        let scene = OptionsScene(size: view.bounds.size)
            
            // Get the SKScene from the loaded GKScene
            
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                    // Present the scene
                
                    view.presentScene(scene)
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
