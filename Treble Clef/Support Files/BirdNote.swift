//
//  BirdCoordinates.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 26..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

// Y coordinates for standard bird game
enum BirdNote: EnumCollection {
    case doh, re, mi, sol, la
    
    var yValues5Lines: [CGFloat] {
        switch self {
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
    
    // nem jó értékek
    var yValues4Lines: [CGFloat] {
        switch self {
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

extension BirdNote {
    
    var yCoordinates5Lines: [CGFloat] {
        return yValues5Lines.map{$0 / 1000}
    }
    
    var yCoordinates4Lines: [CGFloat] {
        return yValues4Lines.map{$0 / 1000}
    }
    
}

extension BirdNote {
    
    static var noteDict: [String: BirdNote] = ["doh": .doh,
                                               "re": .re,
                                               "mi": .mi,
                                               "sol": .sol,
                                               "la": .la];
    // ehelyett nem tudom a saját nevét vagy a rawValue-t használni?
    
    static func getNoteByString(note: String) -> BirdNote? {
        guard let type = BirdNote.noteDict[note] else {
            return nil
        }
        return type
    }
    
    static func getNotes(gameMode: Int) -> [BirdNote] {
        switch gameMode {
        case 2:
            return [.sol, .la]
        case 3:
            return [.doh, .sol, .la]
        case 4:
            return [.doh, .mi, .sol, .la]
        case 5:
            return [.doh, .re, .mi, .sol, .la]
        default:
            return [] // majd itt kéne valamit írni hogy nem jó, figyelmeztetni
        }
    }
    
    var soundFile: String {
        switch self {
        case .doh:
            return "do.wav"
        case .re:
            return "re.wav"
        case .mi:
            return "mi.wav"
        case .sol:
            return "sol.wav"
        case .la:
            return "la.wav"
        }
    }
}

// Helper for coordinates
public protocol CoordinateConverter: Hashable {
    func multiplier() -> CGFloat
}

public extension CoordinateConverter where Self: RawRepresentable, Self.RawValue == CGFloat {
    public func multiplier() -> CGFloat {
        return self.rawValue / 1000
    }
}

// X coordinates for 5 lines standard game
enum BirdXCoordinates5Lines: CGFloat, EnumCollection, CoordinateConverter {
    case note1 = 175
    case note2 = 312
    case note3 = 450
    case note4 = 590
    case note5 = 720
    case note6 = 840
}
