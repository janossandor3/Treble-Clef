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
        
        if (!isValidPasswordString(pwdStr: passwordTextfield.text!)) {
            showPasswordErrorPopup()
            SVProgressHUD.dismiss()
            return
        }
        
        // itt jön a saját ellenőrzésem passwordre (bár lehet hogy a firebasebe be lehet állítani hogy mondjuk minimum 6 karakter és kellenek bele betűk és számok)
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            SVProgressHUD.dismiss()
            
            if error != nil {
                self.passwordTextfield.text = ""
                self.showEmailErrorPopup()
                print(error!)
            } else {
                let defaults = UserDefaults()
                let userID = (user?.user.uid)!
                // itt jönne az hogy a demo cuccból elkérjük az adatokat
                // aztán csinálunk egy új üres profile-t, és az adatokkal (ha volt) feltöltjük azt
                // utána töröljük az ideiglenes adatokat és a UserDefaultsban beállítjuk (vagy hol) mondjuk ID alapján a a currentUsert
                // ezt fogjuk majd mondjuk belépésnél is ellenőrizni. Ha nem nil az ID akkor MainMenure menjünk egyből.
                
                let ref: DatabaseReference! = Database.database().reference()
                ref.child("Users").child(userID).setValue(["user_level": 1])
                
                defaults.set(userID, forKey: DefaulsKeys.PROFILE_ID)
                self.delegate?.identifyUser(id: userID)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func isValidPasswordString(pwdStr:String) -> Bool {
        let pwdRegEx = "(?=.*[0-9])(?=.*[a-z])[A-Za-z0-9]{6,15}"
        
        // kell egy szám, egy kisbetű és min 6 max 15
        
        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        return pwdTest.evaluate(with: pwdStr)
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
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
