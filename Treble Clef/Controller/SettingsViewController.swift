//
//  SettingsViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//


import UIKit
import Firebase
import SVProgressHUD


class SettingsViewController: UIViewController {
    
    weak var delegate: LogoutProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogoutClicked(_ sender: Any) {
        SVProgressHUD.show()
        
        do {
            try Auth.auth().signOut()
            let defaults = UserDefaults()
            defaults.set(nil, forKey: DefaulsKeys.PROFILE_ID)
            dismiss(animated: false, completion: nil)
            delegate?.logout()
            SVProgressHUD.dismiss()
        } catch {
            SVProgressHUD.dismiss()
            print("Cant log out")
        }
        
        // itt kijelentkezünk, meg beállítjuk hogy kijelentkezek meg minden ilyen szar
        // reset is
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
