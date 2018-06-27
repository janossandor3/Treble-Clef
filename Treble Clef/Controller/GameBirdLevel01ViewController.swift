//
//  GameBirdLevel01ViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import Firebase
import SpriteKit

class GameBirdLevel01ViewController: UIViewController, BirdGameLevel1Protocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = BirdGameLevel1Scene(size: view.bounds.size, scoreToEarn: BirdXCoordinates5Lines.allValues.count)
        scene.gameDelegate = self
        self.view = SKView(frame: CGRect(x: view.bounds.maxX * 0.5, y: view.bounds.maxY * 0.5, width: view.bounds.maxX, height: view.bounds.maxY))
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func finishGame(scoreEarned: Int) {
        let ref: DatabaseReference! = Database.database().reference()
        let userID = (Auth.auth().currentUser?.uid)!
        ref.child("Users").child(userID).setValue(["user_level": scoreEarned == BirdXCoordinates5Lines.allValues.count ? 2 : 1])

        navigationController?.popViewController(animated: true)
    }
}
