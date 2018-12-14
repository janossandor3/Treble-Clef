//
//  BirdGameLevel1Scene.swift
//  Treble Clef
//
//  Created on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import SpriteKit

class BirdLevel1Scene: SKScene {
    
    typealias closureType = (Int) -> Void
    
    private let FINISH_BUTTON = "finish_button"
    private let BACK_BUTTON = "back_button"
    private let song: Song?
    private let scoreToEarn: Int
    private var score: Int = 0
    private let finished: closureType
    
    init(size: CGSize, scoreToEarn: Int, song: Song?, finished: @escaping closureType) {
        self.song = song
        self.scoreToEarn = scoreToEarn
        self.finished = finished
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        initBackground()
        initBirds()
    }
    
    func initBackground() {
        let background = SKSpriteNode(imageNamed: "birdGame5LinesBackground")
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(background)
        
        let backSignPost = SKSpriteNode(imageNamed: "backSignPost")
        backSignPost.name = BACK_BUTTON
        backSignPost.zPosition = 10
        backSignPost.size = CGSize(width: self.frame.width / 10, height: self.frame.height / 8)
        backSignPost.position = CGPoint(x: self.frame.width / 14, y: self.frame.height / 15)
        addChild(backSignPost)
    }
    
    func initBirds() {
        if let selectedSong = song {
            let game = BirdLevel1Game(selectedSong)
            for i in 0...scoreToEarn - 1 {
            
                let note: PentatonNote = selectedSong.name == "Random" ? selectedSong.notes[Int(arc4random_uniform(UInt32(selectedSong.possibleNotes.count)))] : selectedSong.notes[i]
                
                let x = size.width * BirdXCoordinates5Lines.allCases[i].multiplier()
                let y = size.height * game.yCoordinates5Lines(note: note)[i]
                
                let bird = Bird(frameHeight: self.frame.height, frameWidth: self.frame.width, x: x, birdNote: note) { [unowned self] in
                    self.nodeRemoved()
                }
                addChild(bird)
                bird.flyDown(x: x, y: y)
            }
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
            if let name = touchedNode.name, name == BACK_BUTTON || name == FINISH_BUTTON {
                finished(score)
            }
        }
        
    }

}
