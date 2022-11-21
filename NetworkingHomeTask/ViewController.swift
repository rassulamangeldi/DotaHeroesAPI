//
//  ViewController.swift
//  NetworkingHomeTask
//
//  Created by Rassul Amangeldi on 07.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var heroesArray = [Heroes]()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showHeroes: UIButton!
    
    var networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        showHeroes.tintColor = .brown
        networkManager.delegate = self
    }
    
    @IBAction func showButtonDidTap(_ sender: UIButton) {
        networkManager.getHeroes()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell")
        var content = cell!.defaultContentConfiguration()
        content.text = heroesArray[indexPath.row].localized_name
        cell!.contentConfiguration = content
        return cell!
    }
}

extension ViewController: NetworkManagerDelegate {
    
    func onShowHeroes(with heroes: [Heroes]) {
        heroesArray = heroes
        tableView.reloadData()
    }
}

