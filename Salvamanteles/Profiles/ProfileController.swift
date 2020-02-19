//
//  ProfileController.swift
//  Salvamanteles
//
//  Created by Javier Piñas on 10/02/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit

class ProfileController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let exampleNameArray: [String] = ["Javi", "Victor", "Diego", "Alex"]
    
    
    @IBOutlet weak var ProfileCollection: UICollectionView!
    
    
    @IBAction func addProfilesButton(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        ProfileCollection.dataSource = self
        ProfileCollection.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exampleNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ProfileCell" , for: indexPath) as! ProfileCell
        //cell.name.text = exampleNameArray[indexPath.row]
        
        return cell
    }
    
    @objc func onClickedprofileButton(_sender: Any) {
        print("Tapped")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
