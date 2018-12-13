//
//  Song.swift
//  Treble Clef
//
//  Created on 2018. 06. 29..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

class Song {
    
    let name: String
    let keynote: String
    var notes: [PentatonNote] = []
    
    init(name: String, notes: [String], keynote: String) {
        self.name = name // és ha nincs? ezeket majd lekezelem
        self.keynote = keynote
        self.notes = getNotes(notes: notes)
    }
    
    func getNotes(notes: [String]) -> [PentatonNote] {
        var n:[PentatonNote] = []
        
        for note in notes {
            if let noteEnum = PentatonNote.getNoteByString(note: note) {
                n.append(noteEnum)
            }
        }
        return n
    }
    
}
