import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var newProfile: UITextField!
    
    let defaults = UserDefaults.standard
    
    @IBAction func changePassButton(_ sender: Any) {
        let user = defaults.dictionary(forKey: "user")!
        
        let password = user["password"] as! String
        
        if currentPass.text! == password && newPass.text! == repeatPass.text! {
            
            _ = HTTPMessenger.init().post(endpoint: "changePassword", params: newPass.text!)
        }
    }
    
    @IBAction func addNewProfile(_ sender: Any) {
        _ = HTTPMessenger.init().post(endpoint: "createProfile", params: newProfile.text!)
    }
}
