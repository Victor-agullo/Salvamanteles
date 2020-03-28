import UIKit

class LoginController: UIViewController {
    
    // obtención de las entradas de la pantalla del login
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    @IBOutlet weak var loginButt: UIButton!
    @IBOutlet weak var imageLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLogo.layer.masksToBounds = true
        imageLogo.layer.cornerRadius = imageLogo.bounds.width / 2
        
        loginButt.layer.shadowColor = UIColor.black.cgColor
        loginButt.layer.shadowOffset = CGSize(width: 3, height: 3)
        loginButt.layer.shadowRadius = 3
        loginButt.layer.shadowOpacity = 1.0
        
        mailEntry.layer.shadowColor = UIColor.black.cgColor
        mailEntry.layer.shadowOffset = CGSize(width: 3, height: 3)
        mailEntry.layer.shadowRadius = 3
        mailEntry.layer.shadowOpacity = 1.0
        
        passEntry.layer.shadowColor = UIColor.black.cgColor
        passEntry.layer.shadowOffset = CGSize(width: 3, height: 3)
        passEntry.layer.shadowRadius = 3
        passEntry.layer.shadowOpacity = 1.0
        
    }
   
    var hadConnected: Bool = Bool()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //si al iniciar la app, hay un "user" guardado en defaults, hace un login automáticamente
        if let params = UserDefaults.standard.dictionary(forKey: "user") {
            gettinInTouch(params: params)
        }
    }
    
    //botón de login
    @IBAction func loginButton(_ sender: UIButton) {
        let params = paramGetter()
        loginButt.isEnabled = false
        gettinInTouch(params: params)
    }
    
    func gettinInTouch(params: Any) {
        
        HTTPMessenger.init().viewJumper(parameters: params, uri: "loginUser", view: self.view, completion: {
            success in self.hadConnected = success
            
            if self.hadConnected == true {
                self.successfullyLogged()
            } else {
                self.loginButt.isEnabled = true
            }
        })
    }
    
    // getter de las entradas de la vista
    func paramGetter() -> Dictionary<String, String> {
        
        let params = [
            "email" : mailEntry.text!,
            "password" : passEntry.text!,
            ]
        return params
    }
    
    // Botón que manda a la ventana de registro
    @IBAction func toRegistryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toRegistry", sender: self)
    }
    
    func successfullyLogged()  {
        performSegue(withIdentifier: "toProfiles", sender: self)
    }
}
