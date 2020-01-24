//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
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
                    UserDefaults.standard.set(parameters, forKey: "user")
                    self.performSegue(withIdentifier: "Registered", sender: from)
                }
                
            case .failure:
                break
            }
        }
    }
    
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "email" : mailEntry.text!,
        ]
        
        // recuperación de contraseña
        let _ = HttpMessenger.post(endpoint: "forgot", params: params)
    }
}
