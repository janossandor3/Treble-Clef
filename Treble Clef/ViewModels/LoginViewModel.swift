//
//  LoginViewModel.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    
    let fir = FirebaseService()
    weak var delegate: LoginProtocol? = nil
    
    func login(email: String, password: String) {
        
        if email.isEmpty || password.isEmpty {
            self.delegate?.loginError(error: "Empty field")
            return
        }
        
        fir.auth.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                self.delegate?.loginError(error: error!.localizedDescription)
            } else {
                let userID = (user?.user.uid)!
                self.fir.login(userID: userID)
                self.delegate?.login(userId: userID)
            }
        }
        
    }
    
}
