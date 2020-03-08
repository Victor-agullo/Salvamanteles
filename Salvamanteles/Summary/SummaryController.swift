import UIKit

class SummaryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var nameArray: [String] = []
    var procedure = ""
    var name = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        saveData(procedure: procedure)
    }
    
    func saveData(procedure: String) {
        
        if procedure == "register" {
            _ = HTTPMessenger.init().post(endpoint: "assignIngredientToProfile", params: getParams())
            SummaryController.nameArray.removeAll()
            
        } else if procedure == "reconsidering" {
            
            _ = HTTPMessenger.init().post(endpoint: "saveSelection", params: getParams())
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
