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
        
        gettinInTouch(params: params)
    }
    
    func gettinInTouch(params: Any) {
        
        HTTPMessenger.init().viewJumper(parameters: params, uri: "loginUser", view: self.view, completion: {
            success in self.hadConnected = success
            
            if self.hadConnected == true {
                self.successfullyLogged()
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
