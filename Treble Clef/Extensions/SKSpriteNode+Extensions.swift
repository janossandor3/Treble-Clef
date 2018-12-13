//
//  SKTexture.swift
//  Treble Clef
//
//  Created by iMind on 2018. 07. 03..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    
    func mirror() {
        self.xScale = -1.0
    }
    
    func playNote(note: PentatonNote) {
        run(SKAction.playSoundFileNamed(note.soundFile, waitForCompletion: false))
    }
    
}
