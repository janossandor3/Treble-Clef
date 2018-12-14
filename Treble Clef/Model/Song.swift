//
//  Song.swift
//  Treble Clef
//
//  Created on 2018. 06. 29..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

struct Song: Codable {
    
    let id: String
    let name: String
    let keynote: String
    let notes: [PentatonNote]
    let possibleNotes: [PentatonNote]
    
    init(id: String, name: String, keynote: String, notes: [String], possibleNotes: [String]) {
        self.id = id
        self.name = name
        self.keynote = keynote
        self.notes = PentatonNote.getNotesByString(notes)
        self.possibleNotes = PentatonNote.getNotesByString(possibleNotes)
    }
    
    func score() -> Int {
        return notes.count
    }
    
}


