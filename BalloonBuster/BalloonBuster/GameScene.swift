//
//  GameScene.swift
//  BalloonBuster
//
//  Created by Amit on 2024-01-15.
//

import SpriteKit

class GameScene: SKScene {
    let firstNode = SKNode()
    let imageNames = [String(0),String(1),String(2),String(3),String(4)]
    var inUseXpoints = [String : CGFloat]()
    var queue: [CGFloat] = []
    let confettiSpriteNode = SKSpriteNode(imageNamed: "giphy-0")
    var confettiFrames = [SKTexture]()
    
    override func didMove(to view : SKView) {
        confettiSpriteNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        confettiSpriteNode.size = CGSize.init(width: self.frame.size.width , height: self.frame.size.height);
        confettiSpriteNode.zPosition = -1;
        addChild(confettiSpriteNode);
        confettiSpriteNode.isHidden = true;
        let textureAtlas = SKTextureAtlas(named: "Confetti-Frame")
        for index in 0..<20 {
            confettiFrames.append(textureAtlas.textureNamed("giphy-"+String(index)))
        }
        self.backgroundColor = UIColor(red: 0.5843137254901961, green: 0.9803921568627451, blue: 0.7372549019607844, alpha: 1.00)
        populateXPoints()
        for index in 0..<imageNames.count {
            let imageName = String(index)
           let ballonTexture =  SKSpriteNode(imageNamed: imageName)
            ballonTexture.name = imageName;
            addChild(ballonTexture)
           // let xPoint = queue.removeFirst()
            let pointIndex = Int.random(in: 0...queue.count-1)
            let xPoint = queue.remove(at: pointIndex );
            inUseXpoints[imageName] = xPoint
            let yPoint = CGFloat(Int.random(in: 50...100))
            ballonTexture.position = CGPoint(x: xPoint, y: frame.minY-yPoint)
            attachMoveAction(texture: ballonTexture, xPoint: xPoint)
        }
    }
    
    func populateXPoints(){
        let minX = self.frame.minX + 50;
        let maxX = self.frame.maxX - 50;
        let totalWidth = maxX - minX;
        for index in 1..<9 {
            let xPoint = minX + (totalWidth * CGFloat(index)/8)
            queue.append(xPoint)
        }
    }
    
    func attachMoveAction(texture: SKNode, xPoint: CGFloat){
        let yPoint = CGFloat(Int.random(in: 50...100))
        texture.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(to: CGPoint(x: self.inUseXpoints[texture.name!]!, y: frame.maxY+100), duration: 1),
                                                    SKAction.run {
           // let imageName = texture.name
          //  let xPoint = self.inUseXpoints[imageName!]
         //   self.queue.append(xPoint!)
         //   let pointIndex = Int.random(in: 0...self.queue.count-1)
         //   let nextXpoint = self.queue.remove(at: pointIndex );
            let nextXpoint = self.getXpoint(texture: texture)
            texture.position = CGPoint(x: nextXpoint, y: self.frame.minY-yPoint)
        }
            ])))
    }
    
    func getXpoint(texture: SKNode) -> CGFloat{
            let imageName = texture.name
            let xPoint = self.inUseXpoints[imageName!]
            self.queue.append(xPoint!)
            let pointIndex = Int.random(in: 0...self.queue.count-1)
            let nextXpoint = self.queue.remove(at: pointIndex );
            self.inUseXpoints[imageName!] = nextXpoint;
        return nextXpoint;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else {
                return
            }
            let location = touch.location(in: self)
            let touchedNodes = nodes(at: location)
        for index in 0..<touchedNodes.count {
            if imageNames.contains(touchedNodes[index].name ?? "") {
            touchedNodes[index].removeAllActions();
            let imageName = touchedNodes[index].name
            let xPoint = inUseXpoints[imageName!]
            queue.append(xPoint!)
                let pointIndex = Int.random(in: 0...queue.count-1)
            let nextXpoint = queue.remove(at: pointIndex );
                handleBurst()
            inUseXpoints[imageName!] = nextXpoint;
                let yPoint = CGFloat(Int.random(in: 50...100))
            touchedNodes[index].position = CGPoint(x: nextXpoint, y: frame.minY-yPoint)
            attachMoveAction(texture: touchedNodes[index], xPoint: nextXpoint)
        }
        }
}
    func handleBurst(){
        self.confettiSpriteNode.isHidden = false;
        confettiSpriteNode.run(SKAction.sequence([SKAction.animate(with: confettiFrames, timePerFrame: 0.1), SKAction.run {
            self.confettiSpriteNode.isHidden=true
            self.confettiSpriteNode.removeAllActions()
        }]))
    }
}
