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
                self.fir.register(userID: userID)
                self.delegate?.signUp(userId: userID)
            }
        }
    }

}
