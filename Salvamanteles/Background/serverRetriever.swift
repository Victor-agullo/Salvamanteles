import UIKit

class serverRetriever: UIViewController {
    
    static var restaurantsArray: Array<String> = []
    static var nameCategories: Dictionary<String, Any> = [:]
    
    // llamada al gestor de respuestas
    var HttpMessenger = HTTPMessenger()
    
    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    func infoGatherer() {
        
        // realiza el get
        let get = self.HttpMessenger.get(endpoint: "getFinalFood")
        
        // recoge la respuesta
        get.responseJSON { response in
            
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                
                self.arraysDistributor(jsonArray: jsonArray!)
            }
        }
    }
    
    // bucle que desgrana el array del JSON en los arrays que necesitamos
    func arraysDistributor(jsonArray: NSArray) {
        
        for item in jsonArray as! [NSDictionary] {
            
            let restaurants = item["name"] as! String
            let categories = item["dishes"] as! Dictionary<String,Any>
            
            for dish in categories {
                var cat = item["name"] as! String
                var type = item["type"] as! Int8
                var description = item["description"] as! String
                
                serverRetriever.nameCategories["categoria"] = cat
                serverRetriever.nameCategories["categoria"] = type
                serverRetriever.nameCategories["categoria"] = description
            }
            
            serverRetriever.restaurantsArray.append(restaurants)
        }
    }
}
