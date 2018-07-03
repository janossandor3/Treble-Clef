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
    
    var type: CatTextures
    var note: PentatonNotes
    var xPosition: CGFloat
    var yPosition: CGFloat
    var direction: Direction
    weak var delegate: CatTouchedProtocol?
    
    init(frameHeight: CGFloat, frameWidth: CGFloat, x: CGFloat, y: CGFloat, note: PentatonNotes, direction: Direction) {
        type = CatTextures.allValues[Int(arc4random_uniform(UInt32(CatTextures.allValues.count)))]
        self.note = note
        self.direction = direction
        xPosition = x
        yPosition = y
        
        let texture = SKTexture(imageNamed: "sittingCat") // ez itt így nem lesz jó de most mindegy
        super.init(texture: texture, color: UIColor.brown, size: CGSize(width: frameWidth / 5.8, height: frameHeight / 4.8))
        
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
        let playNote = SKAction.playSoundFileNamed(note.soundFile, waitForCompletion: false)
        run(SKAction.group([playNote, animate()])) { [unowned self] () -> Void in
            self.delegate?.catDone()
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
    
    func walkAnimation(direction: Direction) -> SKAction {
        var catAnimation: [SKTexture] = []
        for textureName in type.getWalkAnimationTextures(direction: direction).textureNames {
            catAnimation.append(type.getWalkAnimationTextures(direction: direction).textureNamed(textureName))
        }

        return SKAction.animate(with: catAnimation, timePerFrame: 0.1)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.catTouched(cat: self)
    }
}
