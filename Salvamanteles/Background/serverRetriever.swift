import UIKit

class serverRetriever: UIViewController {
    
    static var restaurantsArray: Array<String> = []
    static var namesArray: [[String]] = []
    static var typesArray: [Int] = []
    static var descriptionsArray: [String] = []
    
    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    static func infoGatherer() {
        restaurantsArray.removeAll()
        namesArray.removeAll()
        typesArray.removeAll()
        descriptionsArray.removeAll()
        
        let params = ["name" : ProfileController.profile]

        // prepara el get
        let get = HTTPMessenger.init().post(endpoint: "getFinalFood", params: params)
        
        // realiza el get
        get.responseJSON { response in
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                var first: [String] = []
                var second: [String] = []
                var third: [String] = []
                var fourth: [String] = []
                var fifth: [String] = []
                
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                
                for item in jsonArray as! [NSDictionary] {
                    
                    let restaurants = item["name"] as! String
                    let categories = item["dishes"]
                    
                    for dish in categories as! [NSDictionary] {
                        let name = dish["name"] as! String
                        let type = dish["type"] as! Int
                        let description = dish["description"] as! String
                        
                        switch type {
                        case 0:
                            first.append(name)
                        case 1:
                            second.append(name)
                        case 2:
                            third.append(name)
                        case 3:
                            fourth.append(name)
                        case 4:
                            fifth.append(name)
                        default:
                            break
                        }
                        serverRetriever.typesArray.append(type)
                        serverRetriever.descriptionsArray.append(description)
                    }
                    serverRetriever.namesArray.append(first+second+third+fourth+fifth)
                    serverRetriever.restaurantsArray.append(restaurants)
                }
            }
        }
    }
    
    static var categoriesList: [String] = []
    static var allergens: [String] = []
    static var allergensList: [[String]] = []
    
    func loadAllergens() {
        //getListedIngredients
        let foods = HTTPMessenger.init().get(endpoint: "dummy")
        
        foods.responseJSON { response in

            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                
                for item in jsonArray as! [NSDictionary] {
                    let cat = item["name"] as! String
                    
                    for i in item["ingredients"] as! [NSDictionary] {
                        let allergen = i["name"] as! String
                        
                        serverRetriever.allergens.append(allergen)
                    }
                    serverRetriever.categoriesList.append(cat)
                }
                serverRetriever.allergensList.append(serverRetriever.allergens)
                serverRetriever.allergens.removeAll()
            }
        }
    }
}
