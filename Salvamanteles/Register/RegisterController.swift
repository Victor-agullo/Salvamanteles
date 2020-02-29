import UIKit

class RegisterController: UIViewController{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorMail: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    
    var hadConnected: Bool = Bool()
    static var newProfile = ""
    
    override func viewDidLoad() {
        
        serverRetriever.init().loadAllergens()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        let mail = validator.init().validateMail(field: emailField)
        let name = validator.init().validateName(field: nameField)
        let pass = validator.init().validatePass(entry: passField)
        
        if mail == " " && name == " " && pass == " " {
            
            let params = paramGetter()
            
            HTTPMessenger.init().viewJumper(parameters: params, uri: "createUser", view: self.view, completion: {
                
                success in self.hadConnected = success
                
                if self.hadConnected == true {
                    RegisterController.newProfile = self.nameField.text!
                    self.performSegue(withIdentifier: "toForbidden", sender: self)
                }
            })
        } else {
            
            errorName.text! = name
            errorMail.text! = mail
            errorPass.text! = pass
        }
    }
    
    // getter de las entradas de la vista
    func paramGetter() -> Dictionary<String, String> {
        
        let params = [
            "name" : nameField.text!,
            "email" : emailField.text!,
            "password" : passField.text!,
            ]
        
        return params
    }
    
    @IBAction func toLoginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toLogin", sender: Any?.self)
    }
}
