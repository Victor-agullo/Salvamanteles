//
//  serverRetriever.swift
//  Salvamanteles
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class serverRetriever: UIViewController {
    
    var namesArray: Array<String> = []
    var restaurantsArray: Array<String> = []
    var categoriesArray: Array<String> = []
    var dishesArray: Array<String> = []
    var allergensArray: Array<String> = []
    
    // llamada al gestor de respuestas
    var HttpMessenger = HTTPMessenger()
    
    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    func infoGatherer(thisCollectionView: UICollectionView) {
        
        // realiza el get
        let get = self.HttpMessenger.get(endpoint: "endpointAlServer")
        
        // recoge la respuesta
        get.responseJSON { response in
            
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                
                self.arraysDistributor(jsonArray: jsonArray!)
                
                // recarga la vista para hacer efectivos los cambios
                thisCollectionView.reloadData()
            }
        }
    }
    
    // bucle que desgrana el array del JSON en los arrays que necesitamos
    func arraysDistributor(jsonArray: NSArray) {
        
        for item in jsonArray as! [NSDictionary] {
            
            let names = item[""] as! String
            let restaurants = item[""] as! String
            let categories = item[""] as! String
            let dishes = item[""] as! String
            let allergens = item[""] as! String
            
            namesArray.append(names)
            restaurantsArray.append(restaurants)
            categoriesArray.append(categories)
            dishesArray.append(dishes)
            allergensArray.append(allergens)
        }
    }
}
