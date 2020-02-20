//
//  SettingsController.swift
//  Salvamanteles
//
//  Created by Víctor Agulló on 14/2/20.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
   
    @IBAction func changeLanguage(_ sender: Any) {
    }
 
    @IBAction func backToRest(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var currentPass: UITextField!
    
    @IBOutlet weak var newPass: UITextField!
    
    @IBOutlet weak var repeatPass: UITextField!
    
    @IBAction func changePassButton(_ sender: Any) {
    }
    
    
    @IBOutlet weak var newProfile: UITextField!
    
    
    @IBAction func addNewProfile(_ sender: Any) {
    }
    
    @IBAction func saveChangesButton(_ sender: Any) {
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postNewPass()
        postAddNewProfile()
    }
    
    func postNewPass() {
        let url = URL(string: "aquí va la petición de cambiar contraseña")
        
        //Alamofire.request(url!, method: .post, parameters: asin, encoding: JSONEncoder.default, headers: nil).responseJSON { (response) in
        //print(response)
    }
    
    func postAddNewProfile() {
        let url = URL(string: "aquí va la petición de añadir nuevo perfil")
        
        //Alamofire.request(url!, method: .post, parameters: asin, encoding: JSONEncoder.default, headers: nil).responseJSON { (response) in
        //print(response)
    }
    
    
    
    
    
    
    
    
    
    
    
}
