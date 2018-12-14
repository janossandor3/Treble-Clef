//
//  SongsSservice.swift
//  Treble Clef
//
//  Created on 2018. 12. 14.
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

final class SongsService {
    
    static func getSongsFromJSON() -> [Song] {
        var songs:[Song] = []
        
        Songs.allCases.forEach { song in
            if let url = Bundle.main.url(forResource: song.rawValue, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Song.self, from: data)
                    songs.append(jsonData)
                } catch {
                    print("error:\(error)")
                }
            }
        }
        
        return songs
    }
    
}
