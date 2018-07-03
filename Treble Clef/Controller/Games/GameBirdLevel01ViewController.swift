//
//  GameBirdLevel01ViewController.swift
//  Treble Clef
//
//  Created by iMind on 2018. 06. 25..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit
import SpriteKit

class GameBirdLevel01ViewController: UIViewController {
    
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = BirdGameLevel01Scene(size: view.bounds.size, scoreToEarn: BirdXCoordinates5Lines.allValues.count)
        scene.gameDelegate = self
        scene.song = song
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

extension GameBirdLevel01ViewController: BirdGameLevel01Protocol {
    
    func finishGame(scoreEarned: Int) {
        navigationController?.popViewController(animated: true)
    }
    
}
