import UIKit

class DishesController: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selected: [String] = []
    
    let example = [["Hamburguesa", "uetr"], ["Patatas"], ["Fanta de naranja"], ["asdf"], ["asdfgh"]]
    
    let categorias: Array<String> = ["beverages", "first", "second", "cuarto", "quinta categoría"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return example.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(categorias[section])"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return example[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DishesCell", for: indexPath) as? DishesCell)!
        
        cell.dishName.text! = example[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? DishesCell
        
        cell!.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        let platoElegido = cell!.dishName?.text!
        
        selected.append(platoElegido!)
        print(selected)
    }
    
    @IBAction func sendDataButton(_ sender: RoundButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! SummaryController
        
        nextScreen.nameArray = selected
    }
}
