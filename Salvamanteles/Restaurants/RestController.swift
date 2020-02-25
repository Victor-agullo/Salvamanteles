import UIKit

class RestController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    let restList = ["Burguer king", "McDonalds", "VIPS", "Ginos", "El Chino De Abajo", "Bar Ricadas"]
    
    var categoriesOfSelectedRest: [String] = []
    
    //var restaurantsList = serverRetriever.restaurantsArray
    //var optionsList = serverRetriever.optionsArray

    var searchController : UISearchController!
    
    var resultsController = UITableViewController()
    
    var filteredRests = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = serverRetriever.init().infoGatherer
        
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
            
        } else {
            return filteredRests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! RestCells
        
        if tableView == self.tableView {
            cell.name.text = restList[indexPath.row]
            //cell.options.text = optionsList[indexPath.row]
        }else{
            cell.name.text = filteredRests[indexPath.row]
            //cell.options.text = optionsList[indexPath.row]
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! DishesController
        
        //nextScreen.categorias = categoriesOfSelectedRest
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! RestCells

        let restaurant = cell.name.text!
        
        /*
        for item in restaurantsList[restaurant] {
            categoriesOfSelectedRest.append(item)
        }
        */
        performSegue(withIdentifier: "toDishes", sender: self)
    }
}
