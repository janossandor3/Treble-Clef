//
//  BirdGameListViewModel.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 29..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SwiftyJSON

class BirdGameListViewModel {
    
    // native JSON es codable
    
    // igazából ez is kimehetne valami külön helyre ahol a JSON olvasás/írás történne. És itt csak azt használnám
    func getSongsFromJSON() -> [Song] {
        let path = Bundle.main.path(forResource: "songs", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        var songs:[Song] = []
        
        do {
            let json = try JSON(data: data! as Data)
            for i in 0...json["songs"].count - 1 {
                
                var name: String = ""
                if let na = json["songs"][i]["name"].string {
                    name = na
                }
                
                var notes: [String] = []
                if let n = json["songs"][i]["notes"].arrayObject {
                    notes = n as! [String]
                }
                
                var keynote: String = ""
                if let k = json["songs"][i]["keynote"].string {
                    keynote = k
                }
                
                songs.append(Song(name: name, notes: notes, keynote: keynote))
            }
        } catch {
            print(error)
        }

        return songs
    }
    
}
