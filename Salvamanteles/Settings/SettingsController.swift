import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var currentPass: UITextField!
    
    @IBOutlet weak var newPass: UITextField!
    
    @IBOutlet weak var repeatPass: UITextField!
    
    @IBOutlet weak var newProfile: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewProfile(_ sender: Any) {
        
        _ = HTTPMessenger.init().post(endpoint: "uri", params: "parameters")
    }
    
    @IBAction func saveChangesButton(_ sender: Any) {
    }
    
    @IBAction func changePassButton(_ sender: Any) {
        
        _ = HTTPMessenger.init().post(endpoint: "uri", params: "parameters")
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
    }
    
    func posting(uri: String, parameters: Any) {
        _ = HTTPMessenger.init().post(endpoint: "uri", params: "parameters")
    }
}
