//
//  NetworkManager.swift
//  NetworkingHomeTask
//
//  Created by Rassul Amangeldi on 07.11.2022.
//

import Foundation

protocol NetworkManagerDelegate {
    func onShowHeroes(with heroes: [Heroes])
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    func getHeroes() {
        
        let urlString = "https://api.opendota.com/api/heroes"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print ("some error \(error.localizedDescription)")
            } else {
                guard let safeData =  data else { return }
                let decoder = JSONDecoder()
                do {
                    let heroes = try decoder.decode([Heroes].self, from: safeData)
                    DispatchQueue.main.async {
                        delegate?.onShowHeroes(with: heroes)
                    }
                } catch {
                    print ("parsing error \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
