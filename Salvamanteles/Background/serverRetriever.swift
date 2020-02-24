import UIKit

class serverRetriever: UIViewController {
    
    static var restaurantsArray: Array<String> = []
    static var categoriesArray: Array<String> = []
    static var descriptionsArray: Array<String> = []
    
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
            
            serverRetriever.restaurantsArray.append(restaurants)
            serverRetriever.categoriesArray.append(categories)
            serverRetriever.descriptionsArray.append(descriptions)
        }
    }
}
