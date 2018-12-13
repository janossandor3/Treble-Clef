//
//  LogInViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    private var viewModel: LoginViewModel?
    weak var delegate : IdentifyUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(
                loginSuccessful: { userId in
                    self.login(userId: userId)
            },
                loginError: { error in
                    self.loginError(error: error)
            })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        SVProgressHUD.show()
        if let vm = viewModel {
            vm.login(email: emailTextfield.text!, password: passwordTextfield.text!)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController {
    
    func login(userId: String) {
        SVProgressHUD.dismiss()
        self.delegate?.identifyUser(id: userId)
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginError(error: String) {
        SVProgressHUD.dismiss()
        showErrorPopup(error: error)
    }
    
}
