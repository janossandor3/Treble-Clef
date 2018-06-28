//
//  RegisterViewModel.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import Firebase

class RegisterViewModel {
    
    let fir = FirebaseService()
    weak var delegate: RegisterProtocol? = nil
    
    func signUp(email: String, password: String) {
        
        if !email.isValidEmail() {
            self.delegate?.emailError()
            return
        }
        
        if !password.isValidPassword() {
            self.delegate?.passwordError()
            return
        }
        
        fir.auth.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                self.delegate?.signUpError(error: error!.localizedDescription)
            } else {
                let userID = (user?.user.uid)!
                
                // ezt is ki kéne küldeni a firebase servicebe
                // itt jönne az hogy a demo cuccból elkérjük az adatokat
                // aztán csinálunk egy új üres profile-t, és az adatokkal (ha volt) feltöltjük azt
                // utána töröljük az ideiglenes adatokat és a UserDefaultsban beállítjuk (vagy hol) mondjuk ID alapján a a currentUsert
                // ezt fogjuk majd mondjuk belépésnél is ellenőrizni. Ha nem nil az ID akkor MainMenure menjünk egyből.
                
                let ref: DatabaseReference! = Database.database().reference()
                ref.child("Users").child(userID).setValue(["user_level": 1])
                
                
                UserDefaults().set(userID, forKey: DefaulsKeys.PROFILE_ID)
                self.delegate?.signUp(userId: userID)
            }
        }
    }

}
