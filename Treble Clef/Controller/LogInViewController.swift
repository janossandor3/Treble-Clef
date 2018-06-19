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

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    var delegate : IdentifyUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Login")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        // firebase check és ha a vége el van fogadva akkor segue perform és go MAIN
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            SVProgressHUD.dismiss()
            
            if error != nil {
                print(error!)
            } else {
                print((user?.user.uid)!)
                self.delegate?.identifyUser(id: (user?.user.uid)!)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
