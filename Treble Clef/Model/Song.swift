//
//  Song.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 29..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

class Song {
    
    let name: String
    let keynote: String
    var notes: [BirdNote] = []
    
    init(name: String, notes: [String], keynote: String) {
        self.name = name // és ha nincs? ezeket majd lekezelem
        self.keynote = keynote
        self.notes = getBirdnotes(notes: notes)
    }
    
    func getBirdnotes(notes: [String]) -> [BirdNote] {
        var n:[BirdNote] = []
        
        for note in notes {
            if let birdNote = BirdNote.getNoteByString(note: note) {
                n.append(birdNote)
            }
        }
        return n
    }
    
}
