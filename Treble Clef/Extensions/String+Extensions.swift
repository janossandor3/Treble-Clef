//
//  String.swift
//  Treble Clef
//
//  Created on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

extension String {
    
    func isValidPassword() -> Bool {
        let pwdRegEx = "(?=.*[0-9])(?=.*[a-z])[A-Za-z0-9]{6,15}"
        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        return pwdTest.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
