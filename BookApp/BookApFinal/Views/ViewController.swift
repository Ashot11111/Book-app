import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bookSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSourse = [Item]()
    var searchedBook = [Item]()
    
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager().getBook { itemArray in
            DispatchQueue.main.async {
                self.dataSourse = itemArray
                self.tableView.reloadData()
            }
        }
        self.bookSearchBar.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchedBook.count
        } else {
            return dataSourse.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookTableViewCell
        if searching {
            let model = self.searchedBook[indexPath.row]
            cell.drawCellBymodel(model: model)
        } else  {
            let model = self.dataSourse[indexPath.row]
            cell.drawCellBymodel(model: model)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            let model = self.searchedBook[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.product = model
            
            self.present(vc, animated: true)
        } else {
            let model = self.dataSourse[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.product = model
            
            self.present(vc, animated: true)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedBook = dataSourse.filter { $0.volumeInfo.title.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}










