//
//  GameScene.swift
//  BalloonBuster
//
//  Created by Amit on 2024-01-15.
//

import SpriteKit

class GameScene: SKScene {
    let firstNode = SKNode()
    let imageNames = [String(0)]
    var inUseXpoints = [String : CGFloat]()
    var queue: [CGFloat] = []
    override func didMove(to view : SKView) {
        self.backgroundColor = UIColor.white
        populateXPoints()
        for index in 0..<imageNames.count {
            let imageName = String(index)
           let ballonTexture =  SKSpriteNode(imageNamed: imageName)
            ballonTexture.name = imageName;
            addChild(ballonTexture)
            let xPoint = queue.removeFirst()
            inUseXpoints[imageName] = xPoint
            ballonTexture.position = CGPoint(x: xPoint, y: frame.minY-100)
            attachMoveAction(texture: ballonTexture, xPoint: xPoint)
        }
    }
    
    func populateXPoints(){
        let totalWidth = self.frame.maxX - self.frame.minX;
        for index in 1..<9 {
            let xPoint = self.frame.minX + (totalWidth * CGFloat(index)/8)
            queue.append(xPoint)
        }
    }
    
    func attachMoveAction(texture: SKNode, xPoint: CGFloat){
        texture.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(to: CGPoint(x: xPoint, y: frame.maxY+100), duration: 1),
                                                    SKAction.run {
            texture.position = CGPoint(x: xPoint, y: self.frame.minY-100)
        }
            ])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else {
                return
            }
            let location = touch.location(in: self)
            
            let touchedNodes = nodes(at: location)
        for index in 0..<touchedNodes.count {
            touchedNodes[index].removeAllActions();
            let imageName = touchedNodes[index].name
            let xPoint = inUseXpoints[imageName!]
            queue.append(xPoint!)
            let nextXpoint = queue.removeFirst();
            inUseXpoints[imageName!] = nextXpoint;
            touchedNodes[index].position = CGPoint(x: nextXpoint, y: frame.minY-100)
            attachMoveAction(texture: touchedNodes[index], xPoint: nextXpoint)
        }
}
}
