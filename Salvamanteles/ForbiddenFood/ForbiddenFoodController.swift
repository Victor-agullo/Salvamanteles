
//
//  ForbiddenFoodController.swift
//  Salvamanteles
//
//  Created by Javier Piñas on 10/02/2020.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit

var actualRow = 0

class ForbiddenFoodController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var textBox: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    var TableList: [[String]] = [["Queso","Leche","Yougurt"],
                                 ["Trucha","Atún","Lubina"], ["Pollo","Cerdo","Vacuno"],["Cigalas","Almejas","Ostras"]]
    
    
    var PickerList = ["Lactosa","Pescado","Carne","Marisco"]
    
    
    //var alergiaPescado = ["Trucha","Atún","Lubina"]
    //var alergiaCarne = ["Pollo","Cerdo","Vacuno"]
    //var alergiaMarisco = ["Cigalas","Almejas","Ostras"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    

}
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return PickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow
        row: Int, forComponent component: Int) ->String? {
        
        self.view.endEditing(true)
        return PickerList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow
        row: Int, inComponent component : Int) {
        
        self.textBox.text = self.PickerList[row]
        
        
       
          actualRow = row
       
        print(TableList)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        
       
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == self.textBox {
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TableList[actualRow].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForbiddenCells", for: indexPath) as! ForbiddenCells
        cell.alergeName.text = TableList[actualRow][indexPath.row]
        
        return cell
    }
    
    
    
    
    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
}
