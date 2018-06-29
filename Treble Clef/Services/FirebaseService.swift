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
    
    let defaults = UserDefaults()
    let auth = Auth.auth()
    let ref: DatabaseReference! = Database.database().reference()
    
    func login(userID: String) {
        
        UserDefaults().set(userID, forKey: DefaulsKeys.PROFILE_ID)
        User.currentUser.userID = userID
        ref.child("Users").child(userID).child("user_level").observeSingleEvent(of: .value, with: { (snapshot) in
            User.currentUser.userLevel = (snapshot.value as? Int)!
        }) {
            (error) in print(error.localizedDescription)
        }
        
    }
    
    func register(userID: String) {
        
        UserDefaults().set(userID, forKey: DefaulsKeys.PROFILE_ID)
        User.currentUser.userID = userID
        User.currentUser.userLevel = 1
        ref.child("Users").child(userID).setValue(["user_level": User.currentUser.userLevel])
        
    }
    
    func logout() -> Bool {
        
        do {
            try auth.signOut()
            defaults.set(nil, forKey: DefaulsKeys.PROFILE_ID)
            User.currentUser.reset()
            return true
        } catch {
            print("Cant log out") // error
            return false
        }
        
    }
    
    func updateUserlevel(userLevel: Int) {
        
        if let currentUser = auth.currentUser {
            let userID = currentUser.uid
            ref.child("Users").child(userID).setValue(["user_level": userLevel])
            User.currentUser.userLevel = userLevel
        }
        
    }
    
    // ide még egyéb firebase-es dolgok jönnek
    
    
}
