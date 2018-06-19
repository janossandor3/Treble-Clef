//
//  WelcomeViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 19..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, IdentifyUser {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        print("Welcome")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func identifyUser(id: String) {
        // userdefaultsba itt rakom majd be
        print("itt vagyok. nem megy a navigation controller? Vagy mi?")
        navigationController?.popToRootViewController(animated: true)
        
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
