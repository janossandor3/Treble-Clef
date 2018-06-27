//
//  BirdGameLevel1Scene.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import SpriteKit
import Firebase

protocol BirdGameLevel1Protocol {
    func finishGame()
}

class BirdGameLevel1Scene: SKScene, NodeRemovedProtocol {
    
    private let FINISH_BUTTON = "finish_button"
    
    var gameDelegate : BirdGameLevel1Protocol?
    
    let scoreToEarn: Int = BirdXCoordinates5Lines.allValues.count
    var score: Int = 0
    
    override func didMove(to view: SKView) {
        initBackground()
        initBirds()
    }
    
    func initBackground() {
        let background = SKSpriteNode(imageNamed: "birdGame5LinesBackground")
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(background)
    }
    
    func initBirds() {
        for i in 0...scoreToEarn - 1 {
            let randomNote = Int(arc4random_uniform(UInt32(BirdNote.getNotes(gameMode: 5).count)))
            let note = BirdNote.getNotes(gameMode: 5)[randomNote]
            let x = size.width * BirdXCoordinates5Lines.allValues[i].multiplier()
            let y = size.height * note.yCoordinates5Lines[i]
            
            let bird = Bird(frameHeight: self.frame.height, frameWidth: self.frame.width, x: x, birdNote: note)
            bird.delegate = self
            addChild(bird)
            bird.flyDown(x: x, y: y)
        }
    }
    
    func nodeRemoved() {
        score += 1
        if score == scoreToEarn {
            finishGame()
        }
    }
    
    func finishGame() {
        let fadedBackground = SKSpriteNode()
        fadedBackground.color = UIColor.black
        fadedBackground.alpha = 0.1
        fadedBackground.zPosition = 20
        fadedBackground.size = CGSize(width: self.frame.width, height: self.frame.height)
        fadedBackground.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(fadedBackground)
        fadedBackground.run(SKAction.fadeAlpha(to: 0.3, duration: 1))
        
        let finishButton = SKSpriteNode(imageNamed: "birdGame5")
        finishButton.name = FINISH_BUTTON
        finishButton.alpha = 0
        finishButton.zPosition = 20
        finishButton.size = CGSize(width: self.frame.width / 2, height: self.frame.height / 2)
        finishButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(finishButton)
        finishButton.run(SKAction.fadeIn(withDuration: 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if let name = touchedNode.name {
                if name == FINISH_BUTTON{
                    gameDelegate?.finishGame()
                }
            }
            
        }
    }

}
