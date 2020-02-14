
//
//  ForbiddenFoodController.swift
//  Salvamanteles
//
//  Created by Javier Piñas on 10/02/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit

class CellClass: UITableViewCell {
    
}
class ForbiddenFoodController: UIViewController{
    
    
    @IBOutlet weak var btnSelectRestriction: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y,
                                 width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action:
            #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,options: .curveEaseInOut,
                       animations: {
                        self.transparentView.alpha = 0.5
                        self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y +
                            frames.height + 5,width: frames.width, height: CGFloat(self.dataSource.count * 50)) //aquí misteriosamente sí lo pilla 
        } , completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,options: .curveEaseInOut,
                       animations: {
                        self.transparentView.alpha = 0
                        self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y +
                            frames.height,width: frames.width, height: 0)
        } , completion: nil)
    }
    
    @IBAction func onClickSelectRestrict(_ sender: Any) {
        dataSource = ["Lactosa", "Pescado", "Marisco", "Frutas"]
        selectedButton = btnSelectRestriction
        addTransparentView(frames: btnSelectRestriction.frame)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
      return dataSource.count //no me pilla el nombre del array, no sé porqué
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row] //sigue sin pillarme el array
        return cell
    }
}
