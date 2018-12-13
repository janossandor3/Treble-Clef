//
//  LoginViewModel.swift
//  Treble Clef
//
//  Created on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    
    typealias loginType = (String) -> Void
    
    private let fir = FirebaseService()
    private let loginSuccessful: loginType
    private let loginError: loginType
    
    init(loginSuccessful: @escaping loginType, loginError: @escaping loginType) {
        self.loginSuccessful = loginSuccessful
        self.loginError = loginError
    }
    
//    weak var delegate: LoginProtocol? = nil
//
//    func login(userId: String)
//    func loginError(error: String)
    
    // login eredmenye az ne delegateen keresztul legyen hanem closure-okon keresztul
    func login(email: String, password: String) {
        
        if email.isEmpty || password.isEmpty {
            loginError("Empty field")
            return
        }
        
        fir.auth.signIn(withEmail: email, password: password) { [unowned self] (user, error) in
            if error != nil {
                print(error!)
                self.loginError(error!.localizedDescription)
            } else {
                let userID = (user?.user.uid)!
                self.fir.login(userID: userID)
                self.loginSuccessful(userID)
            }
        }
        
    }
    
}
