//
//  SummaryController.swift
//  Salvamanteles
//
//  Created by Javier Piñas on 10/02/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit
class SummaryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var numberOfRows = 0
    
    let nameArray: [String] = ["Cheeseburger","Patatas","Nachos"]
    
    let imageArray: [UIImage] = [#imageLiteral(resourceName: "dejar"), #imageLiteral(resourceName: "dejar"), #imageLiteral(resourceName: "dejar")]
   
    
    weak var TableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView?.delegate = self
        TableView?.dataSource = self
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (TableView?.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell)!
        cell.name.text = nameArray[indexPath.row]
        cell.deleteimage.image = imageArray[indexPath.row]
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
