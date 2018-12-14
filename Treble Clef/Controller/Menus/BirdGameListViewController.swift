//
//  BirdGameListViewController.swift
//  Treble Clef
//
//  Created on 2018. 06. 28..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit

class BirdGameListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel = BirdGameListViewModel()
    private var selectedSong: Song?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = SongsService.getSongsFromJSON()[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongsService.getSongsFromJSON().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSong = SongsService.getSongsFromJSON()[indexPath.row]
        performSegue(withIdentifier: "goToBirdGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBirdGame" {
            let destinationVC = segue.destination as! BirdLevel1ViewController
            destinationVC.song = selectedSong
        }
    }
    
}
