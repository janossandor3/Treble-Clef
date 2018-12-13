//
//  SettingsViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//


import UIKit
import Firebase
import SVProgressHUD

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userLevel: UILabel!

    private let fir = FirebaseService()
    var logoutClicked: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLevel.text = "User Level: \(User.currentUser.userLevel)"
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
        if fir.logout() {
            dismiss(animated: false, completion: nil)
            if let logout = logoutClicked {
                logout()
            }
            SVProgressHUD.dismiss()
        } else {
            SVProgressHUD.dismiss()
        }
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
