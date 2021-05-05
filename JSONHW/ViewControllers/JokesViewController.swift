//
//  JokesViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import UIKit

class JokesViewController: UITableViewController {
    
    //MARK: - Public properties
    var jokes: [Joke] = []
    
    //MARK: - Override methods
        override func viewDidLoad() {
        super.viewDidLoad()
            
            navigationItem.title = "Дурацкие шуточки"
        
            alamofireFetchData(from: APIManager.shared.joke)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath) as! JokeTableViewCell
        
        let joke = jokes[indexPath.row]
        
        cell.configureCell(with: joke)
        return cell
    }
    
    //MARK: - Private Methods
    func alamofireFetchData(from url: String?) {
        NetworkManager.shared.alamofireFetchJokes(from: url) { result in
            switch result {
            
            case .success(let jokes):
                
                self.jokes = jokes
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

