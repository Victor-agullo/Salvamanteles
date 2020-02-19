//
//  MainController.swift
//  Salvamanteles
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//
import UIKit
//Esto está relacionado con el af_setImage para que saque la imagen de la url
import AlamofireImage

class RestController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //ejemplos
    
    let exampleNameArray: [String] = ["Burger", "McDonald"]
    let exampleImgArray: [UIImage] = [#imageLiteral(resourceName: "mas"), #imageLiteral(resourceName: "ajustes")]
    let exampleOptionArray: [String] = ["patata", "hamburguesa"]
    
    /*
    var candies: [Candy] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies: [Candy] = []
    */
    
    //La vista de la colección
    //@IBOutlet weak var restaurantsCollection: UICollectionView!
    
    @IBOutlet weak var restaurantsCollection: UICollectionView!
    
    @IBOutlet weak var toSettings: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsCollection.dataSource = self
        restaurantsCollection.delegate = self
        
       
    
        
        // llamada a la función que recoge la información desde la clase serverRetriever en Background
       //serverRetriever.init().infoGatherer(thisCollectionView: restaurantsCollection)
        
        /*
        candies = Candy.candies()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = Candy.Category.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
 */
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    */
    
    // obtención dinámica del número de celdas a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exampleNameArray.count
    }
    
    // rellena las celdas con los arrays públicos obtenidos del serverRetriever
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // establece cual es la celda
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestCells", for: indexPath) as! RestCells
        
        cell.restName.text = exampleNameArray[indexPath.row]
        cell.options.text = exampleOptionArray[indexPath.row]
        cell.logo.image = exampleImgArray[indexPath.row]
        
        // transforma el string obtenido del server en un formato de array
        /*
        let url = URL(string: imageURLArray[indexPath.row])
        
        // establece los valores de cada objeto de la celda
        
        cell.restName.text = nameArray[indexPath.row]
        cell.options.text = optionsArray[indexPath.row]
        cell.logo.af_setImage(withURL: url!)
        */
        return cell
    }
    
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowDetailSegue",
            let indexPath = restaurantsCollection.indexPathsForSelectedItems,
            let detailViewController = segue.destination as? DishesController
            else {
                return
        }
        
        let candy: Candy
        
        if isFiltering {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        DishesController.candy = candy
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: Candy.Category? = nil) {
        filteredCandies = candies.filter { (candy: Candy) -> Bool in
            let doesCategoryMatch = category == .all || candy.category == category
            
            if isSearchBarEmpty {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
            }
        }
        
        restaurantsCollection.reloadData()
    }
 */
}
/*
extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let candy: Candy
        if isFiltering {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category.rawValue
        return cell
    }
}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let category = Candy.Category(rawValue:
            searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, category: category)
    }
}

extension MasterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = Candy.Category(rawValue:
            searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, category: category)
    }
}
*/
