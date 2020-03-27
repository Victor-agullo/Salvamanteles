import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var newProfile: UITextField!
    @IBOutlet weak var profileTodelete: UITextField!
    
    let defaults = UserDefaults.standard
    var profiles = ProfileController.profileArray
    
    @IBAction func changePassButton(_ sender: Any) {
        let user = defaults.dictionary(forKey: "user")!
        
        let password = user["password"] as! String
        
        if currentPass.text! == password && newPass.text! == repeatPass.text! {
            
            let newPassword = HTTPMessenger.init().post(endpoint: "changePassword", params: newPass.text!)
            newPassword.responseJSON {
                response in
                HTTPMessenger.init().tokenSavior(response: response)
            }
        }
    }
    
    @IBAction func addNewProfile(_ sender: Any) {
        var parameters = [
            "name": newProfile.text!
        ]
        ProfileController.profile = newProfile.text!
        
        if profiles.contains(newProfile.text!) && (newProfile.text?.isEmpty)! {
            Toaster.init().showToast(message: "Perfil ya existente o inválido", view: view)
        } else {
            _ = HTTPMessenger.init().post(endpoint: "createProfile", params: parameters)
            performSegue(withIdentifier: "toRegistry", sender: Any?.self)
        }
    }
    
    @IBAction func deleteProfile(_ sender: Any) {
        var parameters = [
            "name": profileTodelete.text!
        ]
        _ = HTTPMessenger.init().post(endpoint: "removeProfile", params: parameters)

        // coger la lista de perfiles de la app y borrarlo
        let indexOfProfile = profiles.index(of: profileTodelete.text!)!

        profiles.remove(at: indexOfProfile)
    }
}
