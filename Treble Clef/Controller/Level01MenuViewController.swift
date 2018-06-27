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
    
    @IBOutlet weak var levelLabel: UILabel! // jó ez full kamu, nem fog kelleni
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let ref: DatabaseReference! = Database.database().reference()
        let userID = (Auth.auth().currentUser?.uid)!
        
        ref.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let userlevel = value?["user_level"] as? Int ?? 1
            self.levelLabel.text = "Level: \(userlevel)"
            
            }) { (error) in
                print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
