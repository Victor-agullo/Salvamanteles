//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let data = UserDefaults.standard.dictionary(forKey: "user") {
            
            viewJumper(parameters: data, uri: "login")
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let params = paramGetter()
        
        viewJumper(parameters: params, uri: "register")
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let params = paramGetter()
        
        viewJumper(parameters: params, uri: "login")
    }
    
    func paramGetter() -> Dictionary<String, String> {
        
         let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!,
        ]
        return params
    }
    
    func viewJumper(parameters: Any, uri: String) {
        
        let from = Any?.self
        
        let hadConnected = HttpMessenger.post(endpoint: uri, params: parameters)
        
        hadConnected.responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if uri == "login"{
                    HttpMessenger.tokenSavior(response: response)
                    self.performSegue(withIdentifier: "Logged", sender: from)
                    
                } else if uri == "register" {
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
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
        ]
        
        let _ = HttpMessenger.post(endpoint: "forgot", params: params)
    }
}
