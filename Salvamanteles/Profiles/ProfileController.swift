import UIKit

class ProfileController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var profileArray: Array<String> = []
    
    static var profile = ""
    
    private static var colors: [UIColor] = []
    
    @IBOutlet weak var ProfileCollection: UICollectionView!
    
    override func viewDidLoad() {
        loadProfiles()
        
        ProfileCollection.dataSource = self
        ProfileCollection.delegate = self
    }
    
    func loadProfiles() {
        let profiles = HTTPMessenger.init().get(endpoint: "getProfiles")
        
        profiles.responseJSON { response in
            
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                let jsonArray = JSON as? NSArray
                
                for item in jsonArray as! [NSDictionary] {
                
                    let profile = item["name"] as! String
                    
                    self.profileArray.append(profile)
                }
                // recarga la vista para hacer efectivos los cambios
                self.ProfileCollection.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfProfiles = profileArray.count
        ProfileController.colorsOfProfiles(numbersOfColor: numberOfProfiles)
        
        return numberOfProfiles
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ProfileCell" , for: indexPath) as! ProfileCell
        
        cell.nameLabel.text = profileArray[indexPath.row]
        cell.backgroundColor = ProfileController.colors[indexPath.row]
        
        return cell
    }
    
    // método que responde a la selección de una app, llevando al usuario a un detalle de los tiempos de esta
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ProfileCell" , for: indexPath) as! ProfileCell
        
        ProfileController.profile = cell.nameLabel.text!
        
        // cambio de pantalla
        performSegue(withIdentifier: "toRestaurants", sender: self)
    }
    
    // método que genera un array de colores aleatorios cuando se le llama
    static private func colorsOfProfiles(numbersOfColor: Int) {
        
        // se genera un array con el número de colores que se pidan
        for _ in 0..<numbersOfColor {
            let red = Double(Int.random(in: 100..<255))
            let green = Double(Int.random(in: 100..<255))
            let blue = Double(Int.random(in: 100..<255))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            
            ProfileController.colors.append(color)
        }
    }
}
