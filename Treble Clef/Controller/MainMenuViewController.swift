//
//  ViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults()
        
//        var key :String = DefaultsKeys.PROFILE_ID
        let profileId = defaults.string(forKey: "profile_id_key")
        if  profileId == nil {
            performSegue(withIdentifier: "goToWelcome", sender: self)
        }
        
        print("Main Menu")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LogoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Cant log out")
        }
        // itt kijelentkezünk, meg beállítjuk hogy kijelentkezek meg minden ilyen szar
        // reset is
        
        performSegue(withIdentifier: "goToWelcome", sender: self)
    }
    
}

