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
        
        var parameters = [
            "password": currentPass.text!,
            "new_password": newPass.text!
        ]
        
         let pass = validator.init().validatePass(entry: newPass)
        
        if currentPass.text! == password && newPass.text! == repeatPass.text! && pass == " " {
            
            
            
            let newPassword = HTTPMessenger.init().post(endpoint: "changePassword", params: parameters)
            newPassword.responseJSON {
                response in
                
                switch  response.response?.statusCode {
                case 200:
                    HTTPMessenger.init().tokenSavior(response: response)
                    ForbiddenFoodController.createAlert(title: "Contraseña cambiada", message: "La conraseña se ha cambiado correctamente", view: self)
                    
                    let params = [
                        "name" : user["name"],
                        "email" : user["email"],
                        "password" : self.newPass.text!,
                    ]
                    
                    UserDefaults.standard.set(params, forKey: "user")
                    
                    break
                case 401:
                    ForbiddenFoodController.createAlert(title: "Error", message: "La contraseña n coincide", view: self)
                case .none:
                    ForbiddenFoodController.createAlert(title: "Fallo de conexión", message: "Revise su conexión a internet", view: self)
                    break
                case .some(_):
                    break
                }
                
            }
        } else {
              ForbiddenFoodController.createAlert(title: "Error", message: "Revise los campos. La contraseña debe tener al menos 8 caracteres, 1 mayúscula, 1 minúscula, 1 numero y 1 símbolo", view: self)
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
        
        var delete_request = HTTPMessenger.init().post(endpoint: "removeProfile", params: parameters)
        
  
        
        if delete_request.response!.statusCode == 200 {
            
            // coger la lista de perfiles de la app y borrarlo
            let indexOfProfile = profiles.index(of: self.profileTodelete.text!)!
            
            self.profiles.remove(at: indexOfProfile)
            
            performSegue(withIdentifier: "ToProfiles", sender: self)
            
        } else {
            
           ForbiddenFoodController.createAlert(title: "No encontrado", message: "no se ha encontrado un perfil con ese nombre", view: self)
            
        }


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
