import UIKit

class ForbiddenFoodController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UISearchResultsUpdating{
    
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var foodTable: UITableView!
    
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    var filteredRests = [String]()
    var currentCategory = 0
    static var categoriesList: [String] = ["Lactosa","Pescado","Carne","Marisco"]
    static var allergensList: [[String]] = [["Queso","Leche","Yougurt"],
                                            ["Trucha","Atún","Lubina"],
                                            ["Pollo","Cerdo","Vacuno"],
                                            ["Cigalas","Almejas","Ostras"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loadData()
        
        foodTable.delegate = self
        foodTable.dataSource = self
        
        self.creatingSearhBar()
        self.tableSettings()
    }
    /*
     func loadData() {
     let foods = HTTPMessenger.init().get(endpoint: "dummy")
     
     foods.responseJSON { response in
     print(response)
     // se cerciona de que haya respuesta
     if let JSON = response.result.value {
     print(JSON)
     // pasa el JSON a array
     let jsonArray = JSON as? NSArray
     print(jsonArray)
     Según lo que se devuelva la bbdd sabremos cómo abordar la respuesta.
     }
     }
     }
     */
    func creatingSearhBar() {
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.foodTable.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
    }
    
    func tableSettings() {
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredRests = ForbiddenFoodController.allergensList[currentCategory].filter {
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
        return ForbiddenFoodController.categoriesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->String? {
        self.view.endEditing(true)
        return ForbiddenFoodController.categoriesList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component : Int) {
        currentCategory = row
        
        DispatchQueue.main.async {
            self.foodTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.foodTable {
            return ForbiddenFoodController.allergensList[currentCategory].count
            
        } else {
            return filteredRests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.foodTable.dequeueReusableCell(withIdentifier: "ForbiddenCells") as! ForbiddenCells
        
        if tableView == self.foodTable {
            cell.alergeName.text = ForbiddenFoodController.allergensList[currentCategory][indexPath.row]
            
        }else{
            cell.alergeName.text = filteredRests[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ForbiddenCells
        
        let platoElegido = cell.alergeName.text!
        
        if !SummaryController.nameArray.contains(platoElegido) {
            cell.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            SummaryController.nameArray.append(platoElegido)
            
        } else {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.7031216025, blue: 0, alpha: 1)
            let indexOfCell = SummaryController.nameArray.index(of: platoElegido)!
            SummaryController.nameArray.remove(at: indexOfCell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! SummaryController
        
        nextScreen.procedure = "register"
    }
}

