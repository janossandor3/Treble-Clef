//
//  CatGameLevel1Scene.swift
//  Treble Clef
//
//  Created by iMind on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import SpriteKit
import Firebase

protocol CatGameLevel01Protocol {
    func finishGame(scoreEarned: Int)
}

class CatGameLevel01Scene: SKScene {
    
    private let FINISH_BUTTON = "finish_button"
    private let BACK_BUTTON = "back_button"
    
    var gameDelegate : CatGameLevel01Protocol?

    let scoreToEarn: Int
    var score: Int = 0
    let game = CatGameLevel01Properties.init()
    
    var chosenNote: PentatonNotes?
    
    init(size: CGSize, scoreToEarn: Int) {
        self.scoreToEarn = scoreToEarn
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        initBackground()
        initCats()
        
        nextNote()
    }
    
    func initBackground() {
        let background = SKSpriteNode(imageNamed: "catsGameBackground")
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(background)
        
        let backSignPost = SKSpriteNode(imageNamed: "backSign")
        backSignPost.name = BACK_BUTTON
        backSignPost.zPosition = 10
        backSignPost.size = CGSize(width: self.frame.width / 10, height: self.frame.height / 12)
        backSignPost.position = CGPoint(x: self.frame.width / 14, y: self.frame.height / 15)
        addChild(backSignPost)
    }
    
    func initCats() {
        for note in game.notes {
            let coordinates = game.catCoordinates(note: note)
            let direction = game.catDirections(note: note)
            let cat = Cat(frameHeight: self.frame.height, frameWidth: self.frame.width, x: coordinates.x, y: coordinates.y, note: note, direction: direction)
            cat.name = "cat"
            cat.delegate = self
            addChild(cat)
        }
    }
    
    func nextNote() {
        chooseNote()
        playNote()
    }
    
    func chooseNote() {
        let randomNote = game.notes[Int(arc4random_uniform(UInt32(game.notes.count)))]
        
        if let prev = chosenNote {
            if prev == randomNote {
                chooseNote()
            } else {
                chosenNote = randomNote
            }
        } else {
            chosenNote = randomNote
        }
    }
    
    func playNote() {
        let wait = SKAction.wait(forDuration: 2)
        let playSound = SKAction.playSoundFileNamed(chosenNote!.soundFile, waitForCompletion: false)
        run(SKAction.sequence([wait, playSound])) { [unowned self] () -> Void in
            self.setCatsActive(active: true)
        }
    }
    
    func setCatsActive(active: Bool) {
        for node in children {
            if node.name == "cat" {
                let cat = node as! Cat
                cat.isUserInteractionEnabled = active
            }
        }
    }
    
    func finishGame() {
//        let fadedBackground = SKSpriteNode()
//        fadedBackground.color = UIColor.black
//        fadedBackground.alpha = 0.1
//        fadedBackground.zPosition = 20
//        fadedBackground.size = CGSize(width: self.frame.width, height: self.frame.height)
//        fadedBackground.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
//        addChild(fadedBackground)
//        fadedBackground.run(SKAction.fadeAlpha(to: 0.3, duration: 1))
//
//        let finishButton = SKSpriteNode(imageNamed: "birdGame5")
//        finishButton.name = FINISH_BUTTON
//        finishButton.alpha = 0
//        finishButton.zPosition = 20
//        finishButton.size = CGSize(width: self.frame.width / 2, height: self.frame.height / 2)
//        finishButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
//        addChild(finishButton)
//        finishButton.run(SKAction.fadeIn(withDuration: 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if let name = touchedNode.name {
                if name == BACK_BUTTON || name == FINISH_BUTTON {
                    gameDelegate?.finishGame(scoreEarned: score)
                }
            }

        }
    }
    
}

extension CatGameLevel01Scene: CatTouchedProtocol {
    
    func catTouched(cat: Cat) {
        if let currentNote = chosenNote {
            if currentNote == cat.note {
                setCatsActive(active: false)
                cat.goodSelected()
            }
        }
    }
    
    func catDone() {
        nextNote()
    }
    
}
