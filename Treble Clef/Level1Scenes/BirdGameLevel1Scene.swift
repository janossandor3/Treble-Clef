//
//  BirdGameLevel1Scene.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import SpriteKit

enum BirdCoordinates: CGFloat {
    case column1 = 150
    case column2 = 300
    case column3 = 450
    case column4 = 600
    case column5 = 750
    case column6 = 900
}

class BirdGameLevel1Scene: SKScene {
    
    override func didMove(to view: SKView) {
        // Basics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // Background
        let background = SKSpriteNode(imageNamed: "birdGame5LinesBackground")
        
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(background)
        
        // na ez gecironda
        let Xcoordinates : [BirdCoordinates] = [BirdCoordinates.column1, BirdCoordinates.column2, BirdCoordinates.column3, BirdCoordinates.column4, BirdCoordinates.column5, BirdCoordinates.column6]
        
        // TEST
        for i in 0...5 {
            let bird = SKSpriteNode(imageNamed: "BirdSitA")
            bird.size = CGSize(width: self.frame.width / 5, height: self.frame.height / 5)
            bird.zPosition = 10
            
            bird.position = CGPoint(x: (size.width / 12) * (Xcoordinates[i].rawValue / 100), y: size.height / 2)
            addChild(bird)
        }
    }

}

extension BirdGameLevel1Scene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
