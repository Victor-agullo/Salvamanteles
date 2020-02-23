import UIKit

class ForbiddenFoodController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UISearchResultsUpdating{
    
    var actualRow = 0

    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    var filteredRests = [String]()
    
    var TableList: [[String]] = [["Queso","Leche","Yougurt"],
                                 ["Trucha","Atún","Lubina"],
                                 ["Pollo","Cerdo","Vacuno"],
                                 ["Cigalas","Almejas","Ostras"]]
    
    var PickerList = ["Lactosa","Pescado","Carne","Marisco"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadProfiles()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.creatingSearhBar()
        self.tableSettings()
    }
    /*
    var TableList: [[String]] = []
    var PickerList: [String] = []
    
    func loadProfiles() {
        let profiles = HTTPMessenger.init().get(endpoint: "dummy")
        print(profiles)
        
        profiles.responseJSON { response in
            print(response)
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                print(JSON)
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                print(jsonArray)
                for item in jsonArray as! [NSDictionary] {

                    let ingredientes = item["ingredientes"] as! [String]
                    let categorias = item["categorias"] as! String
                    
                    self.TableList.append(ingredientes)
                    self.PickerList.append(categorias)
                }
                print(self.TableList)
            }
        }
    }
    */
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
        
        // self.filteredRests = self.TableList[actualRow].filter {
           self.filteredRests = self.TableList[actualRow].filter {
            (rest: String) -> Bool in
            
            if rest.lowercased().contains(self.searchController.searchBar.text!.lowercased()){
                return true
            } else{
                return false
            }
        }
        self.resultsController.tableView.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->String? {
        
        self.view.endEditing(true)
        return PickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component : Int) {
          actualRow = row
       
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return TableList[actualRow].count
        }
        else {
            return filteredRests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ForbiddenCells") as! ForbiddenCells
        
        if tableView == self.tableView {
            cell.alergeName.text = TableList[actualRow][indexPath.row]
            
        }else{
            cell.alergeName.text = filteredRests[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell!.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        print(cell!)
    }
}
