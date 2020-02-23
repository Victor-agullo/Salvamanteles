import UIKit

class serverRetriever: UIViewController {
    
    var restaurantsArray: Array<String> = []
    var categoriesArray: Array<String> = []
    var descriptionsArray: Array<String> = []
    
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
            
            let restaurants = item["restaurants"] as! String
            let categories = item["categories"] as! String
            let descriptions = item["descriptions"] as! String
            
            restaurantsArray.append(restaurants)
            categoriesArray.append(categories)
            descriptionsArray.append(descriptions)
        }
    }
}
