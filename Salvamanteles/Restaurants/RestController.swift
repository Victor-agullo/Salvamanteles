import UIKit

class RestController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController : UISearchController!
    
    var resultsController = UITableViewController()
    
    let restList = ["uno", "dos", "tres", "cuatro", "cinco", "seis"]
    
    var filteredRests = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatingSearhBar()
        self.tableSettings()
    }
    
    func creatingSearhBar() {
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
    }
    
    func tableSettings() {
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredRests = self.restList.filter {
            
            (rest: String) -> Bool in
            
            if rest.lowercased().contains(self.searchController.searchBar.text!.lowercased()){
                return true
            } else{
                return false
            }
        }
        self.resultsController.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return restList.count
        }
        else {
            return filteredRests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RestCells", for: indexPath) as! RestCells
        
        if tableView != self.tableView {
            cell.name.text! = restList[indexPath.row]
            cell.options.text! = restList[indexPath.row]
        }else{
            cell.name.text! = filteredRests[indexPath.row]
            cell.options.text! = filteredRests[indexPath.row]
        }
        
        return cell
    }
}
