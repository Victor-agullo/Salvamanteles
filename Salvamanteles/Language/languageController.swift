
//
//  File.swift
//  Salvamanteles
//
//  Created by alumnos on 23/01/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit

class languageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func toEng(_ sender: UIButton) {
        languageChange()
    }
    
    @IBAction func toEsp(_ sender: UIButton) {
        languageChange()
    }
    
    func languageChange() {
        let buttonTitle = NSLocalizedString("bear", comment: "The name of the animal")
        print(buttonTitle)
    }
}
