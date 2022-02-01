//
//  CharacterListTableViewController.swift
//  Thrones
//
//  Created by Arian Mohajer on 2/1/22.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    
    @IBOutlet weak var pageTitleNavigationItem: UINavigationItem!
    
    var characters: [Character] = []
    
    static var pageNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.fetchCharacters { characters in
            guard let characters = characters else { return }
            self.characters = characters
            
            DispatchQueue.main.async {
                self.updateView()
                self.tableView.reloadData()
            }
        }
        updateView()
    }
    
    func updateView() {
        
        pageTitleNavigationItem.title = "G.O.T. Characters - Page \(CharacterListTableViewController.pageNumber)"
        NetworkController.fetchCharacters { characters in
            guard let characters = characters else { return }
            self.characters = characters
            
            DispatchQueue.main.async {
                self.updateView()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = characters[indexPath.row].name
        cell.detailTextLabel?.text = characters[indexPath.row].culture
        
        return cell
    }
    
    @IBAction func previousPageButtonTapped(_ sender: Any) {
        if CharacterListTableViewController.pageNumber > 1 {
            CharacterListTableViewController.pageNumber -= 1
        }
        updateView()
    }
    
    @IBAction func nextPageButtonTapped(_ sender: Any) {
        
        CharacterListTableViewController.pageNumber += 1
        updateView()
    }
}
