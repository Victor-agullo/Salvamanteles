import UIKit

class DishesController: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneWeak: UIButton!
    
    static let categorias: [String] = ["Bebidas", "Primeros", "Segundos", "Picoteo", "Postres"]
    static var sections: [String] = []
    var menu: [NSDictionary]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        SummaryController.procedure = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileLabel.text! = ProfileController.profile + " está eligiendo en " + RestController.restaurant!

        serverRetriever.menuSetter(menu: menu!)
        tableView.delegate = self
        tableView.dataSource = self
        profileLabel.layer.masksToBounds = true
        profileLabel.layer.cornerRadius = profileLabel.bounds.width / 3.5
        
        doneWeak.layer.shadowColor = UIColor.black.cgColor
        doneWeak.layer.shadowOffset = CGSize(width: 3, height: 3)
        doneWeak.layer.shadowRadius = 3
        doneWeak.layer.shadowOpacity = 1.0
        
        profileLabel.layer.shadowColor = UIColor.black.cgColor
        profileLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        profileLabel.layer.shadowRadius = 3
        profileLabel.layer.shadowOpacity = 1.0
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
        cell.visibleBackground.layer.cornerRadius = cell.bounds.width / 13.5
        cell.visibleBackground.clipsToBounds = true
        
        cell.dishName.text! = serverRetriever.namesArray[indexPath.section][indexPath.row]
        cell.dishDescription.text! = serverRetriever.descriptionsArray[indexPath.section][indexPath.row]
        isSelected(loadingCell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DishesCell
        let platoElegido = cell.dishName.text!
        
        if !SummaryController.nameArray.contains(platoElegido) {
            cell.visibleBackground.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            SummaryController.nameArray.append(platoElegido)
            
        } else {
            cell.visibleBackground.backgroundColor = #colorLiteral(red: 0.7333333333, green: 0.8784313725, blue: 0.8431372549, alpha: 1)
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
            loadingCell.visibleBackground.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            
        } else {
            loadingCell.visibleBackground.backgroundColor = #colorLiteral(red: 0.7333333333, green: 0.8784313725, blue: 0.8431372549, alpha: 1)
        }
    }
}
