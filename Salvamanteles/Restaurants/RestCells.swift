//
//  MainCell.swift
//  Salvamanteles
//
//  Created by alumnos on 14/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class RestCells: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var options: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
