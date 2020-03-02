import UIKit

class serverRetriever: UIViewController {
    
    static var namesArray: [[String]] = []
    static var typesArray: [Int] = []
    static var descriptionsArray: [String] = []
    
    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    static func menuSetter(menu: [NSDictionary]) {
        descriptionsArray.removeAll()
        typesArray.removeAll()
        namesArray.removeAll()
        
        var first: [String] = []
        var second: [String] = []
        var third: [String] = []
        var fourth: [String] = []
        var fifth: [String] = []

        for dish in menu {
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
            descriptionsArray.append(description)
            typesArray.append(type)
        }
        namesArray.append(first+second+third+fourth+fifth)

        for type in typesArray {
            
            let cat = DishesController.categorias[type]

            if !DishesController.sections.contains(cat) {
                DishesController.sections.append(cat)
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
