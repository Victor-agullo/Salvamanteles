import UIKit

class RestController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var restaurantsTable: UITableView!
    
    @IBOutlet weak var profileName: UILabel!
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var filteredRests = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatingSearhBar()
        self.tableSettings()
        profileName.text = ProfileController.profile
    }
    
    func creatingSearhBar() {
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.restaurantsTable.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
    }
    
    func tableSettings() {
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredRests = serverRetriever.restaurantsArray.filter {
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
        if tableView == self.restaurantsTable {
            return serverRetriever.restaurantsArray.count
            
        } else {
            return filteredRests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.restaurantsTable.dequeueReusableCell(withIdentifier: "Cell") as! RestCells
        
        if tableView == self.restaurantsTable {
            cell.name.text = serverRetriever.restaurantsArray[indexPath.row]
        }else{
            cell.name.text = filteredRests[indexPath.row]
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDishes" {
            let nextScreen = segue.destination as! DishesController
            
        } else if segue.identifier == "toSettings" {
            let nextScreen = segue.destination as! SettingsController
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RestCells
        
        let restaurant = cell.name.text!
        
        print(restaurant)
        performSegue(withIdentifier: "toDishes", sender: self)
    }
}
