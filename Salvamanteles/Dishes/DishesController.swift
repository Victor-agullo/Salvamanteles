//
//  DishesController.swift
//  Salvamanteles
//
//  Created by Javier Piñas on 10/02/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit
class DishesController: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    
    var numberOfRows = 0
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DishesCell", for: indexPath) as? DishesCell)!
        
        return cell
    }
    
    
    
    
    
}
