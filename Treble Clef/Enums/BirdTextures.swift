//
//  BirdTextures.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 26..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

enum BirdTextures: String, EnumCollection {

    case birdBlue = "birdBlueSitting"
    case birdYellow = "birdYellowSitting"
    case birdRed = "birdRedSitting"
    
    var getFlyAnimationTextures: SKTextureAtlas {
        switch self {
        case .birdBlue:
            return SKTextureAtlas(named: "birdBlue")
        case .birdYellow:
            return SKTextureAtlas(named: "birdYellow")
        case .birdRed:
            return SKTextureAtlas(named: "birdRed")
        }
    }
    
}
