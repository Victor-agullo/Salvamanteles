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
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (TableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell)!
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
