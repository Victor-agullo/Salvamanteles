import UIKit

class RegisterController: UIViewController{
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorMail: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    @IBOutlet weak var registerButt: UIButton!
    
    var hadConnected: Bool = Bool()
    static var newProfile = ""
    
    @IBAction func registerButton(_ sender: UIButton) {
        registerButt.isEnabled = false
        
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
                } else {
                    self.registerButt.isEnabled = true
                }
            })
        } else {
            
            errorName.text! = name
            errorMail.text! = mail
            errorPass.text! = pass
            registerButt.isEnabled = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButt.layer.shadowColor = UIColor.black.cgColor
        registerButt.layer.shadowOffset = CGSize(width: 3, height: 3)
        registerButt.layer.shadowRadius = 3
        registerButt.layer.shadowOpacity = 1.0
        
        nameField.layer.shadowColor = UIColor.black.cgColor
        nameField.layer.shadowOffset = CGSize(width: 3, height: 3)
        nameField.layer.shadowRadius = 3
        nameField.layer.shadowOpacity = 1.0
        
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 3, height: 3)
        emailField.layer.shadowRadius = 3
        emailField.layer.shadowOpacity = 1.0
        
        passField.layer.shadowColor = UIColor.black.cgColor
        passField.layer.shadowOffset = CGSize(width: 3, height: 3)
        passField.layer.shadowRadius = 3
        passField.layer.shadowOpacity = 1.0
        
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
