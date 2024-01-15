//
//  OptionsScene.swift
//  BalloonBuster
//
//  Created by Amit on 2024-01-15.
//

import SpriteKit

class OptionsScene: SKScene {
    let firstNode = SKNode()
    let buttonNode = SKLabelNode(text: "START");
   
    override func didMove(to view : SKView) {
        self.backgroundColor = UIColor.red
        buttonNode.name = "START"
        addChild(buttonNode);
        buttonNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "START" {
                   changeScene()
              }
         }
    }
    
    func changeScene(){
        let secondScene = GameScene(size: self.size)
        secondScene.scaleMode = scaleMode
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(secondScene, transition: transition)
    }
}
