//
//  Level01MenuViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase

class Level01MenuViewController: UIViewController {
    
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

}
