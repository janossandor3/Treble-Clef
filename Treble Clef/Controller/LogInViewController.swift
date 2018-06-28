//
//  LogInViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    weak var delegate : IdentifyUser?
    let viewModel = LoginViewModel()
    
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
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        SVProgressHUD.show()
        viewModel.login(email: emailTextfield.text!, password: passwordTextfield.text!)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController: LoginProtocol {
    
    func login(userId: String) {
        SVProgressHUD.dismiss()
        self.delegate?.identifyUser(id: userId)
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginError(error: String) {
        SVProgressHUD.dismiss()
        showErrorPopup(error: error)
    }
    
    // hova lehet az ilyeneket kiszervezni?
    func showErrorPopup(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
