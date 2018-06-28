//
//  RegisterProtocol.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

protocol RegisterProtocol: class {
    func signUp(userId: String)
    func signUpError(error: String)
    func emailError()
    func passwordError()
}
