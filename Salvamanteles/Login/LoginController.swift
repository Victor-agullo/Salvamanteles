//
//  ViewController.swift
//  Salvamanteles
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//
import UIKit

var nameEntry = ""
var mailEntry = ""
var passEntry = ""
var errorFromJSON = ""

class LoginController: UIViewController {
    
    //Funcion que crea un label con sus especificaciones, la cual llamaremos cuando sea necesario para mostrarinformación puntual al usuario (mas adelante habra que crear clase especifica con esta funcion)
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height/1.35, width: 300, height: 35))
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: toastLabel.font.fontName, size: 20)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    let urlLogin = ""
    let urlRegister = ""
    
    // obtención de las entradas de la pantalla del login
    
    
    
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    
    var HttpMessenger = HTTPMessenger()

    override func viewDidAppear(_ animated: Bool) {
        
        //si al iniciar la app, hay un "user" guardado en defaults, hace un login automáticamente
        if let data = UserDefaults.standard.dictionary(forKey: "user") {
            
            viewJumper(parameters: data, uri: "login")
        }
    }
    
    // Botón de registro
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        let params = paramGetter()
        
        viewJumper(parameters: params, uri: "register")
    }
    
    
    //botón de login
  
    @IBAction func loginButton(_ sender: UIButton) {
        let params = paramGetter()
        
        viewJumper(parameters: params, uri: "login")
    }
    
    
    // getter de las entradas de la vista
    func paramGetter() -> Dictionary<String, String> {
        
         let params = [
            "name" : nameEntry.text!,
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
        let hadConnected = HttpMessenger.post(endpoint: uri, params: parameters)
        
        // respuesta del server
        hadConnected.responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if uri == "login"{
                    self.HttpMessenger.tokenSavior(response: response)
                    self.performSegue(withIdentifier: "Logged", sender: from)
                } else if uri == "register" {
                    // guarda el usuario en defaults
                    
                    //CODIGO DEPENDIENTE DE CADA CODIGO HTTP DEVUELTO POR API
                    
                    if (self.nameEntry.text != "" && self.passEntry.text != "" && self.mailEntry.text != "") {
                        //POST USER
                        var httpCodeDifferences = self.HttpMessenger.post(endpoint: "register", params: parameters)
                        httpCodeDifferences.responseJSON
                            {
                                response in
                                switch (response.response?.statusCode)
                                {
                                case 200:
                                    UserDefaults.standard.set(parameters, forKey: "user")
                                    self.performSegue(withIdentifier: "Registered", sender: from)
                                    
                                case 401:
                                    var JSONtoString = response.result.value as! [String:Any]
                                    errorFromJSON = JSONtoString["message"] as! String
                                    self.showToast(message: errorFromJSON)
                                default: break
                                }
                        }
                    }
                    else {
                        //Shows toast when the user is not logged
                        self.showToast(message: "Empty fields!")
                    }
                }
                
            case .failure:
                break
            }
        }
    }
    
    //@IBAction func passRecovery(_ sender: UIButton) {
        //let params = [
            //"email" : mailEntry.text!,
        //]
        
        // recuperación de contraseña
        //let _ = HttpMessenger.post(endpoint: "forgot", params: params)
    //}
    
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "email" : mailEntry.text!,
        ]
        
        let _ = HttpMessenger.post(endpoint: "forgot", params: params)
        
    }
    
    
    
    
    
    
    
    
    
}
