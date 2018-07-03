//
//  GameCatLevel1ViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation
import SpriteKit

class GameCatLevel01ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = CatGameLevel01Scene(size: view.bounds.size, scoreToEarn: CatGameLevel01Properties().scoreToEarn)
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
}

extension GameCatLevel01ViewController: CatGameLevel01Protocol {
    
    func finishGame(scoreEarned: Int) {
        navigationController?.popViewController(animated: true)
    }
    
}
