//
//  BirdCoordinates.swift
//  Treble Clef
//
//  Created on 2018. 06. 26..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

// Y coordinates for standard bird game
class BirdLevel1Game: Game {
    
    var song: Song
    var kind: Kind { return .bird }
    
    init(_ song: Song) {
        self.song = song
    }
    
}

extension BirdLevel1Game {
    
    func yCoordinates5Lines(note: PentatonNote) -> [CGFloat] {
        return yValues5Lines(note: note).map{$0 / 1000}
    }
    
    private func yValues5Lines(note: PentatonNote) -> [CGFloat] {
        switch note {
        case .doh:
            return [200, 167, 155, 165, 190, 220]
        case .re:
            return [320, 285, 275, 285, 315, 360]
        case .mi:
            return [444, 400, 390, 400, 438, 488]
        case .sol:
            return [570, 510, 495, 520, 558, 620]
        case .la:
            return [700, 630, 605, 620, 670, 730]
        }
    }
    
    func yCoordinates4Lines(note: PentatonNote) -> [CGFloat] {
        return yValues4Lines(note: note).map{$0 / 1000}
    }
    
    // nem jó értékek
    private func yValues4Lines(note: PentatonNote) -> [CGFloat] {
        switch note {
        case .doh:
            return [155, 125, 115, 125, 153, 184]
        case .mi:
            return [282, 247, 240, 250, 275, 305]
        case .sol:
            return [408, 363, 350, 363, 395, 434]
        case .la:
            return [512, 465, 442, 455, 490, 535]
        default:
            return [] // és akkor itt most mi? Ugye kimaradt a .re
        }
    }
    
}

// X coordinates for 5 lines standard game
enum BirdXCoordinates5Lines: CGFloat, CaseIterable, CoordinateConverter {
    case note1 = 175
    case note2 = 312
    case note3 = 450
    case note4 = 590
    case note5 = 720
    case note6 = 840
}



//  save this for later
//switch song.score() {
//case 2:
//    notes = [.sol, .la]
//    break
//case 3:
//    notes = [.doh, .sol, .la]
//    break
//case 4:
//    notes = [.doh, .mi, .sol, .la]
//    break
//case 5:
//    notes = [.doh, .re, .mi, .sol, .la]
//    break
//default:
//    notes = [] // majd itt kéne valamit írni hogy nem jó, figyelmeztetni
//}
