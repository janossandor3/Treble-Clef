//
//  AuthService.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseService {
    
    let auth = Auth.auth()
    
    func currentUserId() -> String {
        return (auth.currentUser?.uid)!
    }
    
}
