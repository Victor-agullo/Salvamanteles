//
//  serverRetriever.swift
//  Salvamanteles
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class serverRetriever: UIViewController {
    
    // se declaran fuera de la clase para que sean unas variables publicas y accesibles
    static var nameArray: Array<String> = []
    static var optionsArray: Array<String> = []
    static var imageURLArray: Array<String> = []

    

    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    static func infoGatherer(thisCollectionView: UICollectionView) {
        
        // llamada al gestor de respuestas
        var HttpMessenger = HTTPMessenger()
        
        // array genérico para meter la respuesta del get
        var jsonArray: NSArray?
        
        // realiza el get
        let get = HttpMessenger.get(endpoint: "times")
        
        // recoge la respuesta
        get.responseJSON { response in
            
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                jsonArray = JSON as? NSArray
                
                // bucle que desgrana el array del JSON en los arrays que necesitamos según
                // el índice de
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let name = item["name"] as! String
                    let imageURL = item["icon"] as! String
                    let options = item["options"] as! String
                    
                    nameArray.append(name)
                    optionsArray.append(options)
                    imageURLArray.append(imageURL)
                }
                // recarga la vista para hacer efectivos los cambios
                thisCollectionView.reloadData()
            }
        }
    }
}
