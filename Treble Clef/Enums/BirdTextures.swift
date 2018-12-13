//
//  BirdTextures.swift
//  Treble Clef
//
//  Created on 2018. 06. 26..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

enum BirdTextures: String, CaseIterable {

    case birdBlue
    case birdYellow
    case birdRed
    
    var getFlyAnimationTextures: SKTextureAtlas {
        return SKTextureAtlas(named: self.rawValue)
    }
    
}
