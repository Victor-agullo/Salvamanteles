import UIKit

class serverRetriever: UIViewController {
    
    static var namesArray: [[String]] = []
    static var typesArray: [Int] = []
    static var descriptionsArray: [[String]] = []
    
    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    static func menuSetter(menu: [NSDictionary]) {
        descriptionsArray.removeAll()
        namesArray.removeAll()
        
        var first: [String] = []
        var second: [String] = []
        var third: [String] = []
        var fourth: [String] = []
        var fifth: [String] = []
        
        var firstDescription: [String] = []
        var secondDescription: [String] = []
        var thirdDescription: [String] = []
        var fourthDescription: [String] = []
        var fifthDescription: [String] = []
        
        for dish in menu {
            let name = dish["name"] as! String
            let type = dish["type"] as! Int
            let description = dish["description"] as! String
            
            switch type {
            case 0:
                first.append(name)
                firstDescription.append(description)
            case 1:
                second.append(name)
                secondDescription.append(description)
            case 2:
                third.append(name)
                thirdDescription.append(description)
            case 3:
                fourth.append(name)
                fourthDescription.append(description)
            case 4:
                fifth.append(name)
                fifthDescription.append(description)
            default:
                break
            }
        }
        namesArray.append(first)
        namesArray.append(second)
        namesArray.append(third)
        namesArray.append(fourth)
        namesArray.append(fifth)
        descriptionsArray.append(firstDescription)
        descriptionsArray.append(secondDescription)
        descriptionsArray.append(thirdDescription)
        descriptionsArray.append(fourthDescription)
        descriptionsArray.append(fifthDescription)
    }
}
