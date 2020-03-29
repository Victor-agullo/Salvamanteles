import UIKit

class ForbiddenFoodController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UISearchResultsUpdating{
    
 
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var foodTable: UITableView!
    @IBOutlet weak var doneWeak: UIButton!
    
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    var filteredRests = [String]()
    var currentCategory: Int = 0
    var categoriesList: [String] = []
    var allergens: [String] = []
    var allergensList: [[String]] = []
    var didload: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SummaryController.nameArray.removeAll()
        SummaryController.procedure = false
        foodTable.delegate = self
        foodTable.dataSource = self
        infoGatherer()
        
        self.creatingSearhBar()
        self.tableSettings()
        dropDown.layer.masksToBounds = true
        dropDown.layer.cornerRadius = dropDown.bounds.width / 3.5
        
        doneWeak.layer.shadowColor = UIColor.black.cgColor
        doneWeak.layer.shadowOffset = CGSize(width: 3, height: 3)
        doneWeak.layer.shadowRadius = 3
        doneWeak.layer.shadowOpacity = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ForbiddenFoodController.createAlert(title: "Modo de uso", message: "Pincha en una categoría de la ruleta, despúes en un alérgeno de la tabla y por último en ¡Hecho! para ver tu selección", view: self)
    }
    
    public static func createAlert (title: String, message: String, view: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        view.present(alert, animated: true, completion: nil )
    }
    
    func infoGatherer() {
        let foods = HTTPMessenger.init().get(endpoint: "getListedIngredients")
        
        foods.responseJSON { response in
            
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                
                for item in jsonArray as! [NSDictionary] {
                    let cat = item["name"] as! String
                    
                    for i in item["ingredients"] as! [NSDictionary] {
                        let allergen = i["name"] as! String
                        self.allergens.append(allergen)
                    }
                    self.categoriesList.append(cat)
                    self.allergensList.append(self.allergens)
                    self.allergens.removeAll()
                }
                self.didload = true
                self.foodTable.reloadData()
                self.dropDown.reloadAllComponents()
            }
        }
    }
    
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
        
        if didload {
            
            self.filteredRests = allergensList[currentCategory].filter { (rest: String) -> Bool in
                
                if rest.lowercased().contains(self.searchController.searchBar.text!.lowercased()){
                    return true
                    
                } else{
                    return false
                }
            }
            self.resultsController.tableView.reloadData()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->String? {
        self.view.endEditing(true)
        return categoriesList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component : Int) {
        currentCategory = row
        
        DispatchQueue.main.async {
            self.foodTable.reloadData()
        }
    }
    
    func reloadpicker() {
        DispatchQueue.main.async {
            self.foodTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if didload {
            if tableView == self.foodTable {
                return allergensList[currentCategory].count
                
            } else {
                return filteredRests.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.foodTable.dequeueReusableCell(withIdentifier: "ForbiddenCells") as! ForbiddenCells
        
        cell.layer.masksToBounds = true
        cell.visibleBackground.layer.cornerRadius = cell.bounds.width / 13.5
        
        if tableView == self.foodTable {
            cell.alergeName.text = allergensList[currentCategory][indexPath.row]
            isSelected(loadingCell: cell)
            
        } else {
            cell.alergeName.text = filteredRests[indexPath.row]
            isSelected(loadingCell: cell)
        }
        return cell
    }
    
    func isSelected(loadingCell: ForbiddenCells) {
        if SummaryController.nameArray.contains(loadingCell.alergeName.text!) {
            loadingCell.visibleBackground.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            
        } else {
            loadingCell.visibleBackground.backgroundColor = #colorLiteral(red: 1, green: 0.7031216025, blue: 0, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ForbiddenCells
        let platoElegido = cell.alergeName.text!
        
        if !SummaryController.nameArray.contains(platoElegido) {
            cell.visibleBackground.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            SummaryController.nameArray.append(platoElegido)
            
        } else {
            cell.visibleBackground.backgroundColor = #colorLiteral(red: 1, green: 0.7031216025, blue: 0, alpha: 1)
            let indexOfCell = SummaryController.nameArray.index(of: platoElegido)!
            SummaryController.nameArray.remove(at: indexOfCell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! SummaryController
        SummaryController.procedure = false
    }
}
