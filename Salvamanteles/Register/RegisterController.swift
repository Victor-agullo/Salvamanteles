//
//  RegisterController.swift
//  Salvamanteles
//
//  Created by Javier Piñas on 10/02/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit
class RegisterController: UIViewController{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorMail: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        let mail = validator.init().validateMail(field: emailField)
        let name = validator.init().validateName(field: nameField)
        let pass = validator.init().validatePass(entry: passField)
        
        if mail.isEmpty && name.isEmpty && pass.isEmpty {
            
            let params = paramGetter()
            
            LoginController.init().viewJumper(parameters: params, uri: "register")
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
