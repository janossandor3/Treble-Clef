//
//  RegisterViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    private let viewModel = RegisterViewModel()
    weak var delegate : IdentifyUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterButtonCliked(_ sender: Any) {
        SVProgressHUD.show()
        viewModel.signUp(email: emailTextfield.text!, password: passwordTextfield.text!)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterViewController: RegisterProtocol {
    
    func signUp(userId: String) {
        SVProgressHUD.dismiss()
        self.delegate?.identifyUser(id: userId)
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpError(error: String) {
        passwordTextfield.text = ""
        SVProgressHUD.dismiss()
        showErrorPopup(error: error)
    }
    
    func emailError() {
        SVProgressHUD.dismiss()
        showErrorPopup(error: "Invalid email format")
    }
    
    func passwordError() {
        SVProgressHUD.dismiss()
        showErrorPopup(error: "The password must contain a lowercase letter and a number, and the length must be between 6 and 15")
    }
    
}
