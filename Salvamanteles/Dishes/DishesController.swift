import UIKit

class DishesController: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    static let categorias: [String] = ["beverages", "first courses", "second courses", "snacks", "desserts"]
    static var sections: [String] = []
    var menu: [NSDictionary]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        SummaryController.procedure = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileLabel.text! = ProfileController.profile
        
        serverRetriever.menuSetter(menu: menu!)
        tableView.delegate = self
        tableView.dataSource = self
        profileLabel.layer.masksToBounds = true
        profileLabel.layer.cornerRadius = profileLabel.bounds.width / 3.5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DishesController.categorias.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(DishesController.categorias[section])"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverRetriever.namesArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DishesCell", for: indexPath) as? DishesCell)!
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = cell.bounds.width / 13.5
        
        cell.dishName.text! = serverRetriever.namesArray[indexPath.section][indexPath.row]
        cell.dishDescription.text! = serverRetriever.descriptionsArray[indexPath.section][indexPath.row]
        isSelected(loadingCell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DishesCell
        let platoElegido = cell.dishName.text!
        
        if !SummaryController.nameArray.contains(platoElegido) {
            cell.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            SummaryController.nameArray.append(platoElegido)
            
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            let indexOfCell = SummaryController.nameArray.index(of: platoElegido)!
            SummaryController.nameArray.remove(at: indexOfCell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSummary" {
            _ = segue.destination as! SummaryController
        } else if segue.identifier == "toSettings" {
            _ = segue.destination as! SettingsController
        }
    }
    
    func isSelected(loadingCell: DishesCell) {
        if SummaryController.nameArray.contains(loadingCell.dishName.text!) {
            loadingCell.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            
        } else {
            loadingCell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }
    }
}
