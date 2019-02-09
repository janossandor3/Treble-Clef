//
//  SettingsViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//


import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userLevel: UILabel!
    
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
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
