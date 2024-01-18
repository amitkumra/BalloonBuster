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
    let backgroundNode = SKSpriteNode(imageNamed: "background")
    override func didMove(to view : SKView) {
       // self.backgroundColor = UIColor.red
        backgroundNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundNode.size = CGSize.init(width: self.frame.size.width , height: self.frame.size.height);
        backgroundNode.zPosition = -1;
        addChild(backgroundNode);
        buttonNode.color = UIColor.red
        buttonNode.name = "START"
        addChild(buttonNode);
        buttonNode.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 100)
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
    
    func changeScene() {
        let secondScene = GameScene(size: self.size)
        secondScene.scaleMode = scaleMode
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(secondScene, transition: transition)
    }
}
