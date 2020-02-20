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
    
    //@IBOutlet weak var tableView: UITableView!
    
    let exampleArray: [String] = ["Hamburguesa","Patatas","Fanta de naranja"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DishesCell", for: indexPath) as? DishesCell)!
        cell.dishName.text = exampleArray[indexPath.row]
        return cell
    }
    
    
    
    
    
}
