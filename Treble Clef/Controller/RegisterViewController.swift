//
//  RegisterViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    weak var delegate : IdentifyUser?
    let viewModel = RegisterViewModel()
    
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
        showEmailErrorPopup()
    }
    
    func passwordError() {
        SVProgressHUD.dismiss()
        showPasswordErrorPopup()
    }
    
    func showErrorPopup(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showEmailErrorPopup() {
        let alert = UIAlertController(title: "Error", message: "Invalid email format", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showPasswordErrorPopup() {
        let alert = UIAlertController(title: "Error", message: "The password must contain a lowercase letter and a number, and the length must be between 6 and 15", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
