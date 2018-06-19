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
    
    var delegate : IdentifyUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Register")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterButtonCliked(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            SVProgressHUD.dismiss()
            
            if error != nil {
                self.passwordTextfield.text = ""
                print(error!)
            } else {
                
                // itt jönne az hogy a demo cuccból elkérjük az adatokat
                // aztán csinálunk egy új üres profile-t, és az adatokkal (ha volt) feltöltjük azt
                // utána töröljük az ideiglenes adatokat és a UserDefaultsban beállítjuk (vagy hol) mondjuk ID alapján a a currentUsert
                // ezt fogjuk majd mondjuk belépésnél is ellenőrizni. Ha nem nil az ID akkor MainMenure menjünk egyből. 
                print((user?.user.uid)!)
                self.delegate?.identifyUser(id: (user?.user.uid)!)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
