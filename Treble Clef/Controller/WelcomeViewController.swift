//
//  WelcomeViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, IdentifyUser {
    
    var delegate : CheckUser?
    
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
    
    func identifyUser(id: String) {
        navigationController?.popToRootViewController(animated: true)
        delegate?.checkUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogin" {
            let destinationVC = segue.destination as! LogInViewController
            destinationVC.delegate = self
        } else if segue.identifier == "goToRegistration" {
            let destinationVC = segue.destination as! RegisterViewController
            destinationVC.delegate = self
        }
    }
    
}
