//
//  Bird.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 27..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

class Bird: SKSpriteNode {
    
    static let initAction = "INIT_ACTION"
    
    var type: BirdTextures
    var note: BirdNote
    var xPosition: CGFloat
    var yHidden: CGFloat
    var delegate: NodeRemovedProtocol?
    
    init(frameHeight: CGFloat, frameWidth: CGFloat, x: CGFloat, birdNote: BirdNote) {
        type = BirdTextures.allValues[Int(arc4random_uniform(UInt32(BirdTextures.allValues.count)))]
        note = birdNote
        yHidden = frameHeight + frameHeight / 6
        xPosition = x
        
        let texture = SKTexture(imageNamed: "birdBlueSitting") // ez itt így nem lesz jó de most mindegy
        super.init(texture: texture, color: UIColor.brown, size: CGSize(width: frameWidth / 6, height: frameHeight / 6))
        
        zPosition = 10 // ennek utána kell járni majd
        position = CGPoint(x: xPosition, y: yHidden)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flyAnimation() -> SKAction {
        var birdAnimation: [SKTexture] = []
        for textureName in type.getFlyAnimationTextures.textureNames {
            birdAnimation.append(type.getFlyAnimationTextures.textureNamed(textureName))
        }
        
        let flightAnimation = SKAction.animate(with: birdAnimation, timePerFrame: 0.05)
        return SKAction.repeat(flightAnimation, count: 13)
    }
    
    func flyDown(x: CGFloat, y: CGFloat) {
        let moveToInitialPosition = SKAction.move(to: CGPoint(x: x, y: y), duration: 2)
        let flyToInitialPosition = SKAction.group([moveToInitialPosition, flyAnimation()])
        let changeTexture = SKAction.setTexture(SKTexture(imageNamed: type.rawValue))
        run(SKAction.sequence([flyToInitialPosition, changeTexture]), completion: {
            self.isUserInteractionEnabled = true
            self.swing()
        })
    }
    
    func swing() {
        let firstrotate = SKAction.rotate(byAngle: 0.1, duration: (0.8...1.3).random())
        let rotateLeft = SKAction.rotate(byAngle: -0.2, duration: 2)
        let rotateRight = SKAction.rotate(byAngle: 0.2, duration: 2)
        let rotate = SKAction.repeatForever(SKAction.sequence([rotateLeft, rotateRight]))
        run(SKAction.sequence([firstrotate, rotate]), withKey: Bird.initAction)
    }
    
    func flyOff() {
        removeAction(forKey: Bird.initAction)
        let moveUp = SKAction.move(to: CGPoint(x: xPosition, y: yHidden), duration: 1)
        let flyToInitialPosition = SKAction.group([moveUp, flyAnimation()])
        let remove = SKAction.removeFromParent()
        run(SKAction.sequence([flyToInitialPosition, remove]))
    }
    
    func playNote() {
        run(SKAction.playSoundFileNamed(note.soundFile, waitForCompletion: false))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isUserInteractionEnabled = false
        delegate?.nodeRemoved()
        flyOff()
        playNote() // uncomment when not testing
    }
}

extension ClosedRange where Bound : FloatingPoint {
    public func random() -> Bound {
        let max = UInt32.max
        return Bound(arc4random_uniform(max)) / Bound(max) * (upperBound - lowerBound) + lowerBound
    }
}