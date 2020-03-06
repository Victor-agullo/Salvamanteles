import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var newProfile: UITextField!
    @IBOutlet weak var profileTodelete: UITextField!
    
    let defaults = UserDefaults.standard
    
    @IBAction func changePassButton(_ sender: Any) {
        let user = defaults.dictionary(forKey: "user")!
        
        let password = user["password"] as! String
        
        if currentPass.text! == password && newPass.text! == repeatPass.text! {
            
            _ = HTTPMessenger.init().post(endpoint: "changePassword", params: newPass.text!)
        }
    }
    
    @IBAction func addNewProfile(_ sender: Any) {
        var parameters = [
            "name": newProfile.text!
        ]
        
        _ = HTTPMessenger.init().post(endpoint: "createProfile", params: parameters)
        
        ProfileController.profile = newProfile.text!
    }
    
    @IBAction func deleteProfile(_ sender: Any) {
        var parameters = [
            "name": profileTodelete.text!
        ]
        
        _ = HTTPMessenger.init().post(endpoint: "removeProfile", params: parameters)
    }
}
