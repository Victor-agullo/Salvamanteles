import UIKit
class SummaryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let nameArray: [String] = ["Cheeseburger","Patatas","Nachos"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell)!
        
        cell.name.text = nameArray[indexPath.row]
        cell.deletebutton.buttonType
        
        return cell
    }
}
