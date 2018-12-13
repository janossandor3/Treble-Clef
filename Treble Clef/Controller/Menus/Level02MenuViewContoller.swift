//
//  Level02MenuViewContoller.swift
//  Treble Clef
//
//  Created on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit

class Level02MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showErrorPopup(error: "These levels are not created yet")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
