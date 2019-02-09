//
//  LoadingViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 26..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        checkUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMainMenu" {
            let destinationMainMenu = segue.destination as! MainMenuViewController
            destinationMainMenu.delegate = self
        }
    }
}

extension LoadingViewController: CheckUser {
    
    func checkUser() {
        performSegue(withIdentifier: "goToMainMenu", sender: self)
    }
    
}
