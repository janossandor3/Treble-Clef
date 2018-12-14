//
//  CatGameLevel1Scene.swift
//  Treble Clef
//
//  Created on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import SpriteKit
import Firebase


class CatLevel1Scene: SKScene {
    
    typealias closureType = () -> Void
    
    private let FINISH_BUTTON = "finish_button"
    private let BACK_BUTTON = "back_button"
    private let CAT_NAME = "cat"
    
    private let scoreToEarn: Int
    private let game = CatLevel1Game.init()
    private let finished: closureType
    
    private var chosenNote: PentatonNote?
    private var score: Int = 0
    
    init(size: CGSize, scoreToEarn: Int, finished: @escaping closureType) {
        self.scoreToEarn = scoreToEarn
        self.finished = finished
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
        game.notes
            .map { createCat(coordinates: game.catCoordinates(note: $0), direction: game.catDirections(note: $0), note: $0) }
            .forEach(addChild)
    }
    
    func createCat(coordinates: (x: CGFloat, y: CGFloat), direction: Direction, note: PentatonNote) -> Cat {
        return Cat(frameHeight: self.frame.height,
                   frameWidth: self.frame.width,
                   x: coordinates.x,
                   y: coordinates.y,
                   note: note,
                   direction: direction,
                   name: CAT_NAME,
                   catClicked: { [unowned self] cat in self.catClicked(cat: cat)},
                   catDone: { [unowned self] () in self.nextNote()})
    }
    
    func catClicked(cat: Cat) {
        if let currentNote = self.chosenNote, currentNote == cat.note {
            self.setCatsActive(active: false)
            cat.goodSelected()
        }
    }
    
    func nextNote() {
        chooseNote()
        playNote()
    }
    
    func chooseNote() {
        let randomNote = game.notes[Int(arc4random_uniform(UInt32(game.notes.count)))]
        guard let prev = chosenNote else {
            chosenNote = randomNote
            return
        }
        
        if prev == randomNote {
            chooseNote()
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
            if node.name == CAT_NAME {
                let cat = node as! Cat
                cat.isUserInteractionEnabled = active
            }
        }
    }
    
    func finishGame() {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if let name = touchedNode.name, name == BACK_BUTTON || name == FINISH_BUTTON {
                finished()
            }

        }
    }
    
}
