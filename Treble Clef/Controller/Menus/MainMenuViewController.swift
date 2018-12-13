//
//  ViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase

class MainMenuViewController: UIViewController {

    weak var delegate : CheckUser?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            let destinationSettings = segue.destination as! SettingsViewController
            destinationSettings.logoutClicked = { [unowned self] in
                self.logout()
            }
        }
    }
    
    func logout() {
        navigationController?.popToRootViewController(animated: true)
        delegate?.checkUser()
    }
    
}

