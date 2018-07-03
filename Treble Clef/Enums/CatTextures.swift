//
//  CatTextures.swift
//  Treble Clef
//
//  Created by iMind on 2018. 07. 03..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

enum CatTextures: String, EnumCollection {
    
    case cat = "sittingCat"
    
    func getWalkAnimationTextures(direction: Direction) -> SKTextureAtlas {
        return SKTextureAtlas(named: direction == .right ? "walkingCatRight" : "walkingCatLeft")
    }
    
}
