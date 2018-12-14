//
//  Game.swift
//  Treble Clef
//
//  Created on 2018. 12. 13..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

protocol Game {
    var song: Song { get }
    var kind: Kind { get }
}

extension Game {
    var ID: String { return song.name }
    var score: Int64 { return Int64(song.score()) }
}
