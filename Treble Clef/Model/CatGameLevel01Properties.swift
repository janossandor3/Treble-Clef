//
//  CatNotes.swift
//  Treble Clef
//
//  Created on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

class CatGameLevel01Properties {
    
    // these could be read from json
    let scoreToEarn = 5
    let notes = PentatonNote.allCases
    
    func catCoordinates(note: PentatonNote) -> (x: CGFloat, y: CGFloat) {
        switch note {
        case .doh:
            return (x: 220, y: 100)
        case .re:
            return (x: 590, y: 200)
        case .mi:
            return (x: 220, y: 400)
        case .sol:
            return (x: 360, y: 550)
        case .la:
            return (x: 220, y: 700)
        }
    }
    
    func catDirections(note: PentatonNote) -> Direction {
        switch note {
        case .doh, .mi, .la:
            return .right
        case .re, .sol:
            return .left
        }
    }
    
}
