//
//  Cat.swift
//  Treble Clef
//
//  Created by iMind on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

class Cat: SKSpriteNode {
    
    static let initAction = "INIT_ACTION"
    
    private let type: CatTextures
    private let xPosition: CGFloat
    private let yPosition: CGFloat
    private let direction: Direction
    
    private let catClicked: (Cat) -> Void
    private let catDone: () -> Void
    
    let note: PentatonNote
    
    init(frameHeight: CGFloat, frameWidth: CGFloat, x: CGFloat, y: CGFloat, note: PentatonNote, direction: Direction, name: String, catClicked: @escaping (Cat) -> Void, catDone: @escaping () -> Void) {
        type = CatTextures.allValues[Int(arc4random_uniform(UInt32(CatTextures.allValues.count)))]
        self.note = note
        self.direction = direction
        self.catClicked = catClicked
        self.catDone = catDone
        
        xPosition = x
        yPosition = y
        
        // ez az skspritenode saját init-jéhez kell
        let texture = SKTexture(imageNamed: "sittingCat") // ez itt így nem lesz jó de most mindegy
        super.init(texture: texture, color: UIColor.brown, size: CGSize(width: frameWidth / 5.8, height: frameHeight / 4.8))
        
        self.name = name
        zPosition = 10 // ennek utána kell járni majd
        position = CGPoint(x: xPosition, y: yPosition)
        
        if direction != .right {
            self.mirror()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goodSelected() {
//        playNote(note)
        run(animate()) { [unowned self] () -> Void in
            self.catDone()
        }
    }
    
    func animate() -> SKAction {
        let walkRight = SKAction.repeat(walkAnimation(direction: self.direction == .right ? .right : .left), count: 8)
        let moveRight = SKAction.move(by: CGVector(dx: 100, dy: 0), duration: 1.6)
        let goRight = SKAction.group([walkRight, moveRight])
        let walkLeft = SKAction.repeat(walkAnimation(direction: self.direction == .right ? .left : .right), count: 8)
        let moveLeft = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 1.6)
        let goLeft = SKAction.group([walkLeft, moveLeft])
        let goSequence = SKAction.sequence(direction == .right ? [goRight, goLeft] : [goLeft, goRight])
        let changeTextureBack = SKAction.setTexture(SKTexture(imageNamed: type.rawValue))
        return SKAction.sequence([goSequence, changeTextureBack])
    }
    
    func playNote() {
        run(SKAction.playSoundFileNamed(note.soundFile, waitForCompletion: false))
    }
    
    func walkAnimation(direction: Direction) -> SKAction {
        var catAnimation: [SKTexture] = []
        for textureName in type.getWalkAnimationTextures(direction: direction).textureNames {
            catAnimation.append(type.getWalkAnimationTextures(direction: direction).textureNamed(textureName))
        }

        return SKAction.animate(with: catAnimation, timePerFrame: 0.1)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        catClicked(self)
    }
}
