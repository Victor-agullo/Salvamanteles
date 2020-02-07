//
//  MainController.swift
//  Salvamanteles
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
//Esto está relacionado con el af_setImage para que saque la imagen de la url
import AlamofireImage

class RestController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //ejemplos
    
    let exampleNameArray: [String] = ["Burger", "McDonald"]
    let exampleImgArray: [UIImage] = [#imageLiteral(resourceName: "image8"), #imageLiteral(resourceName: "image9")]
    let exampleOptionArray: [String] = ["patata", "hamburguesa"]
    
    
    //La vista de la colección
    @IBOutlet weak var restaurantsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsCollection.dataSource = self
        restaurantsCollection.delegate = self
        
        // llamada a la función que recoge la información desde la clase serverRetriever en Background
       serverRetriever.init().infoGatherer(thisCollectionView: restaurantsCollection)
    }
    
    // obtención dinámica del número de celdas a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    // rellena las celdas con los arrays públicos obtenidos del serverRetriever
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // establece cual es la celda
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restCells", for: indexPath) as! restCells
        
        cell.restName.text = exampleNameArray[indexPath.row]
        cell.options.text = exampleOptionArray[indexPath.row]
        cell.logo.image = exampleImgArray[indexPath.row]
        
        // transforma el string obtenido del server en un formato de array
        /*
        let url = URL(string: imageURLArray[indexPath.row])
        
        // establece los valores de cada objeto de la celda
        
        cell.restName.text = nameArray[indexPath.row]
        cell.options.text = optionsArray[indexPath.row]
        cell.logo.af_setImage(withURL: url!)
        */
        return cell
    }
}
