import UIKit

class RestController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var restaurantsTable: UITableView!
    @IBOutlet weak var profileName: UILabel!
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var filteredRests = [String]()
    static var restaurantsArray: [String] = []
    static var jsonArray: [Any] = []
    var menuOfRestaurant: [Any]?
    
    override func viewDidLoad() {
        profileName.text = ProfileController.profile
        
        infoGatherer()
        
        self.creatingSearhBar()
        self.tableSettings()
    }
    
    func infoGatherer() {
        RestController.restaurantsArray.removeAll()
        
        let params = ["name" : ProfileController.profile]
        let get = HTTPMessenger.init().post(endpoint: "getFinalFood", params: params)
        
        get.responseJSON { response in
            
            if let JSON = response.result.value {
                
                for item in JSON as! [NSDictionary] {
                    let dishes = item["dishes"] as! [Any]
                    
                    if !dishes.isEmpty {
                        let restaurants = item["name"] as! String
                        
                        RestController.jsonArray.append(dishes)
                        RestController.restaurantsArray.append(restaurants)
                    }
                }
                self.restaurantsTable.reloadData()
            }
        }
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
        
        self.filteredRests = RestController.restaurantsArray.filter { (rest: String) -> Bool in
            
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
            return RestController.restaurantsArray.count
            
        } else {
            return filteredRests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.restaurantsTable.dequeueReusableCell(withIdentifier: "Cell") as! RestCells
        
        if tableView == self.restaurantsTable {
            cell.name.text = RestController.restaurantsArray[indexPath.row]
            
        }else {
            cell.name.text = filteredRests[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RestCells
        let restaurant = cell.name.text!
        let indexOfRestaurant = RestController.restaurantsArray.index(of: restaurant)!
        let restaurantChosen = RestController.jsonArray[indexOfRestaurant]

        menuOfRestaurant = restaurantChosen as? [Any]
        
        performSegue(withIdentifier: "toDishes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDishes" {
            let nextScreen = segue.destination as! DishesController
            nextScreen.menu = menuOfRestaurant as? [NSDictionary]
            
        } else if segue.identifier == "toSettings" {
            _ = segue.destination as! SettingsController
        }
    }
}
