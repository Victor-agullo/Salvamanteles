//
//  MainController.swift
//  Bienestapp
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

class RestController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var restaurantsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsCollection.dataSource = self
        restaurantsCollection.delegate = self
       serverRetriever.init().infoGatherer(thisCollectionView: restaurantsCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restCells", for: indexPath) as! restCells
        
        let url = URL(string: imageURLArray[indexPath.row])
        
        cell.restName.text = nameArray[indexPath.row]
        cell.options.text = optionsArray[indexPath.row]
        cell.logo.af_setImage(withURL: url!)
        
        return cell
    }
}
