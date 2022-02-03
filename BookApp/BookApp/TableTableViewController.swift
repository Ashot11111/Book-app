//
//  TableTableViewController.swift
//  BookApp
//
//  Created by Ashot on 31/01/2022.
//

import UIKit

class TableTableViewController: UITableViewController, UISearchBarDelegate {

    let data = ["Arev","Lusin","Citrus"]
    
    var filteredData: [String]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        filteredData = data
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
    }
    //Mark: Serach Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = data
        } else {
            for char in data {
                if char.contains(searchText) {
                    filteredData.append(char)
                }
            }
        }
        self.tableView.reloadData()
    }
}
