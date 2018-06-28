//
//  LoginProtocol.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

protocol LoginProtocol: class {
    func login(userId: String)
    func loginError(error: String)
}
