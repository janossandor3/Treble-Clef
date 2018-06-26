//
//  BirdGameLevel1Scene.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import SpriteKit

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
        
        initBirds()
    }
    
    func initBirds() {
        for i in 0...BirdXCoordinates5Lines.allValues.count - 1 {
            let bird = SKSpriteNode() // ide kell egy randomizálás
            let birdType = BirdTextures.allValues[Int(arc4random_uniform(UInt32(BirdTextures.allValues.count)))]
            bird.size = CGSize(width: self.frame.width / 6, height: self.frame.height / 6)
            bird.zPosition = 10 // ennek utána kell járni majd
            
            let randomNote = Int(arc4random_uniform(UInt32(BirdNotesCoordinates.getNotes(gameMode: 5).count)))
            let x = size.width * BirdXCoordinates5Lines.allValues[i].multiplier()
            let yInitial = size.height * BirdNotesCoordinates.getNotes(gameMode: 5)[randomNote].yCoordinates5Lines[i]
            let yHidden = size.height + bird.size.height
            
            bird.position = CGPoint(x: x, y: yHidden)
            addChild(bird)
            
            var birdAnimation: [SKTexture] = []
            
            for textureName in birdType.getFlyAnimationTextures.textureNames {
                birdAnimation.append(birdType.getFlyAnimationTextures.textureNamed(textureName))
            }
            
            let flightAnimation = SKAction.animate(with: birdAnimation, timePerFrame: 0.05)
            let repeatFlighAnimation = SKAction.repeat(flightAnimation, count: 13)
            let moveToInitialPosition = SKAction.move(to: CGPoint(x: x, y: yInitial), duration: 2)
            let flyToInitialPosition = SKAction.group([moveToInitialPosition, repeatFlighAnimation])
            let changeTexture = SKAction.setTexture(SKTexture(imageNamed: birdType.rawValue))
            let addBirdAction = SKAction.sequence([flyToInitialPosition, changeTexture])
            bird.run(addBirdAction)
        }
    }

}

extension BirdGameLevel1Scene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
