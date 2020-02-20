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
    
    var profile = ""
    
    private static var colors: [UIColor] = []
    
    @IBOutlet weak var ProfileCollection: UICollectionView!
    
    
    @IBAction func addProfilesButton(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        ProfileCollection.dataSource = self
        ProfileCollection.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfProfiles = exampleNameArray.count
        ProfileController.colorsOfProfiles(numbersOfColor: numberOfProfiles)
        
        return numberOfProfiles
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ProfileCell" , for: indexPath) as! ProfileCell
        
        cell.nameLabel.text = exampleNameArray[indexPath.row]
        cell.backgroundColor = ProfileController.colors[indexPath.row]
        
        return cell
    }
    
    // método que responde a la selección de una app, llevando al usuario a un detalle de los tiempos de esta
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // cambio de pantalla
        performSegue(withIdentifier: "toRestaurants", sender: self)
    }
    
    @objc func onClickedprofileButton(_sender: Any) {
        print("Tapped")
    }
    
    // método que genera un array de colores aleatorios cuando se le llama
    static private func colorsOfProfiles(numbersOfColor: Int) {
        
        // se genera un array con el número de colores que se pidan
        for _ in 0..<numbersOfColor {
            let red = Double(Int.random(in: 100..<255))
            let green = Double(Int.random(in: 100..<255))
            let blue = Double(Int.random(in: 100..<255))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            
            ProfileController.colors.append(color)
        }
    }
}
