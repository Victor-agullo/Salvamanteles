//
//  ViewController.swift
//  Salvamanteles
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//
import UIKit

class LoginController: UIViewController {
    
    // obtención de las entradas de la pantalla del login
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    @IBOutlet weak var loginButt: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //si al iniciar la app, hay un "user" guardado en defaults, hace un login automáticamente
        if let data = UserDefaults.standard.dictionary(forKey: "user") {
            
            viewJumper(parameters: data, uri: "login")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passEntry.placeholder = NSLocalizedString("pass", comment: "")
    }
    
    // Botón que manda a la ventana de registro
    @IBAction func toRegistryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toRegistry", sender: Any?.self)
    }
    
    //botón de login
    @IBAction func loginButton(_ sender: UIButton) {
        let params = paramGetter()
        
        viewJumper(parameters: params, uri: "login")
    }
    
    // getter de las entradas de la vista
    func paramGetter() -> Dictionary<String, String> {
        
        let params = [
            "email" : mailEntry.text!,
            "password" : passEntry.text!,
            ]
        return params
    }
    
    // hace un post, cambia de vista si su respuesta es afirmativa y guarda el user si es un registro
    func viewJumper(parameters: Any, uri: String) {
        
        // contexto del segue
        let from = Any?.self
        
        // se realiza el post
        let hadConnected = HTTPMessenger.init().post(endpoint: uri, params: parameters)
        
        // respuesta del server
        hadConnected.responseJSON { response in
            
            switch (response.response?.statusCode) {
                
            case 200:
                
                if uri == "login"{
                    HTTPMessenger.init().tokenSavior(response: response)
                    self.performSegue(withIdentifier: "Logged", sender: from)
                    
                } else if uri == "register" {
                    
                    // guarda el usuario en defaults
                    UserDefaults.standard.set(parameters, forKey: "user")
                    self.performSegue(withIdentifier: "Registered", sender: from)
                }
                break
            case 401:
                
                var JSONtoString = response.result.value as! [String:Any]
                let errorFromJSON = JSONtoString["message"] as! String
                let view = self.view
                Toaster.init().showToast(message: errorFromJSON, view: view!)
                break
                
            case .none:
                let errorConection = "Sin conexión a la base de datos"
                let view = self.view
                Toaster.init().showToast(message: errorConection, view: view!)
                break
                
            case .some(_):
                break
            }
        }
    }
}
