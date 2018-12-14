//
//  PentatonNote.swift
//  Treble Clef
//
//  Created on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

enum PentatonNote: String, CaseIterable, Codable {
    case doh, re, mi, sol, la
    
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
    
    static var noteDict: [String: PentatonNote] = ["doh": .doh,
                                                    "re": .re,
                                                    "mi": .mi,
                                                    "sol": .sol,
                                                    "la": .la];
    
    static func getNoteByString(_ note: String) -> PentatonNote? {
        guard let type = noteDict[note] else {
            return nil
        }
        return type
    }
    
    static func getNotesByString(_ notes: [String]) -> [PentatonNote] {
        var pentatoneNotes:[PentatonNote] = []
        
        notes.forEach { note in
            if let pentatoneNote = PentatonNote.getNoteByString(note) {
                pentatoneNotes.append(pentatoneNote)
            }
        }
        
        return pentatoneNotes
    }
}
