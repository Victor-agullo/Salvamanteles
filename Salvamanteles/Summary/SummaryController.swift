import UIKit

class SummaryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var nameArray: [String] = []
    static var procedure: Bool = true
    var name = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var GoBackButton: UIButton!
    
    @IBOutlet weak var MessageLabel: RoundLabel!
    override func viewWillAppear(_ animated: Bool) {
        
        if SummaryController.procedure {
            self.GoBackButton.setTitle("Elegir menú de otro comensal", for: .normal)
            
        } else {
            self.GoBackButton.setTitle("Guardar y terminar registro", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        GoBackButton.layer.shadowColor = UIColor.black.cgColor
        GoBackButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        GoBackButton.layer.shadowRadius = 3
        GoBackButton.layer.shadowOpacity = 1.0
        
        MessageLabel.layer.shadowColor = UIColor.black.cgColor
        MessageLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        MessageLabel.layer.shadowRadius = 3
        MessageLabel.layer.shadowOpacity = 1.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SummaryController.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell)!
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = cell.bounds.width / 31.5
        
        cell.name.text = SummaryController.nameArray[indexPath.row]
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            SummaryController.nameArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func finishedSelection(_ sender: UIButton) {
        saveData(procedure: SummaryController.procedure)
    }
    
    func saveData(procedure: Bool) {
        
        if procedure {
            _ = HTTPMessenger.init().post(endpoint: "saveSelection", params: getParams())
            
        } else {
            
            _ = HTTPMessenger.init().post(endpoint: "assignIngredientToProfile", params: getParams())
            SummaryController.nameArray.removeAll()
        }
    }
    
    func getParams() -> Dictionary<String,Any> {
        
        if RegisterController.newProfile.isEmpty {
            name = ProfileController.profile
        } else {
            name = RegisterController.newProfile
        }
        
        let parameters = [
            "name" : name,
            "ingredient_names" : SummaryController.nameArray
            ] as [String : Any]
        
        return parameters
    }
}
