//
//  User.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation


class User {
    
    static let currentUser = User()
    
    var userID: String?
    var userLevel: Int = 0
    
    private init() {}
}

extension User {
    
    func reset() {
        self.userID = nil
        self.userLevel = 0
    }
    
}
