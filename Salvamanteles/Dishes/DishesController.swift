import UIKit

class DishesController: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let categorias: [String] = ["beverages", "first courses", "second courses", "snacks", "desserts"]
    var sections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for type in serverRetriever.typesArray {
            var cat = categorias[type]
            
            if !sections.contains(cat) {
                sections.append(cat)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return serverRetriever.namesArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "\(sections[section])"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serverRetriever.namesArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DishesCell", for: indexPath) as? DishesCell)!
        
        cell.dishName.text! = serverRetriever.namesArray[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DishesCell
        
        let platoElegido = cell.dishName.text!
        
        if !SummaryController.nameArray.contains(platoElegido) {
            cell.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            SummaryController.nameArray.append(platoElegido)
            
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.6632347703, green: 0.7946337461, blue: 0.6706491113, alpha: 1)
            let indexOfCell = SummaryController.nameArray.index(of: platoElegido)!
            SummaryController.nameArray.remove(at: indexOfCell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSummary" {
            let nextScreen = segue.destination as! SummaryController
            nextScreen.procedure = "reconsidering"
            
        } else if segue.identifier == "toSettings" {
            _ = segue.destination as! SettingsController
        }
    }
}
