import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var newProfile: UITextField!
    @IBOutlet weak var profileTodelete: UITextField!
    
    @IBOutlet weak var changeWeak: UIButton!
    @IBOutlet weak var addWeak: UIButton!
    @IBOutlet weak var deleteWeak: UIButton!
    
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
        
        if profiles.contains(newProfile.text!) || (newProfile.text?.isEmpty)! {
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
    override func viewDidLoad() {
        currentPass.layer.shadowColor = UIColor.black.cgColor
        currentPass.layer.shadowOffset = CGSize(width: 3, height: 3)
        currentPass.layer.shadowRadius = 3
        currentPass.layer.shadowOpacity = 1.0
        
        newPass.layer.shadowColor = UIColor.black.cgColor
        newPass.layer.shadowOffset = CGSize(width: 3, height: 3)
        newPass.layer.shadowRadius = 3
        newPass.layer.shadowOpacity = 1.0
        
        repeatPass.layer.shadowColor = UIColor.black.cgColor
        repeatPass.layer.shadowOffset = CGSize(width: 3, height: 3)
        repeatPass.layer.shadowRadius = 3
        repeatPass.layer.shadowOpacity = 1.0
        
        newProfile.layer.shadowColor = UIColor.black.cgColor
        newProfile.layer.shadowOffset = CGSize(width: 3, height: 3)
        newProfile.layer.shadowRadius = 3
        newProfile.layer.shadowOpacity = 1.0
        
        profileTodelete.layer.shadowColor = UIColor.black.cgColor
        profileTodelete.layer.shadowOffset = CGSize(width: 3, height: 3)
        profileTodelete.layer.shadowRadius = 3
        profileTodelete.layer.shadowOpacity = 1.0
        
        changeWeak.layer.shadowColor = UIColor.black.cgColor
        changeWeak.layer.shadowOffset = CGSize(width: 3, height: 3)
        changeWeak.layer.shadowRadius = 3
        changeWeak.layer.shadowOpacity = 1.0
        
        addWeak.layer.shadowColor = UIColor.black.cgColor
        addWeak.layer.shadowOffset = CGSize(width: 3, height: 3)
        addWeak.layer.shadowRadius = 3
        addWeak.layer.shadowOpacity = 1.0
        
        deleteWeak.layer.shadowColor = UIColor.black.cgColor
        deleteWeak.layer.shadowOffset = CGSize(width: 3, height: 3)
        deleteWeak.layer.shadowRadius = 3
        deleteWeak.layer.shadowOpacity = 1.0
        
        
    }
}
