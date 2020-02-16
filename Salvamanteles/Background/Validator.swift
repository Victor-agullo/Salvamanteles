//
//  validator.swift
//  salvamanteles
//
//  Created by Víctor Agulló on 13/2/20.
//  Copyright © 2020 Thorn&Wheat. All rights reserved.
//

import UIKit

class validator {
    
    // validar campo del nombre
    func validateName(field: UITextField) -> String {
        
        let text = field.text!
        
        // si el texto del campo está vacio, salta el mensaje de error
        if text.isEmpty {
            field.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
            return "Este campo no puede estar vacio"
        } else {
            
            field.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return " "
        }
    }
    
    // validar campo del mail
    func validateMail(field: UITextField) -> String {
        
        let text = field.text!
        
        field.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        // si el texto del campo está vacio, salta el mensaje de error
        if text.isEmpty {
            
            return "Este campo no puede estar vacio"
            
            // si el texto del campo no es correcto por cualquier motivo, se notifica
        } else if !text.isEmail() {
            
            return "Mail no válido"
        } else {
            
            field.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return " "
        }
    }
    
    // validar campo de la contraseña
    func validatePass(entry: UITextField) -> String {
        
        let text = entry.text!
        var uppercase = false
        var lowercase = false
        var int = false
        var symbol = false
        
        entry.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        // si el texto del campo está vacio, salta el mensaje de error
        if text.isEmpty {
            
            return "Este campo no puede estar vacio"
            
            // si el texto del campo es más largo de 8 caracteres, continua comprobando
        } else if text.count >= 8 {
            
            // mapea el texto recibido como un conjunto de caracteres
            let arrayEntry = text.map { String($0) }
            
            for i in arrayEntry {
                
                // Comprueba que el caracter actual sea una minúscula
                if i.rangeOfCharacter(from: .lowercaseLetters)  != nil {
                    
                    lowercase = true
                    continue
                    
                    // Comprueba que el caracter actual sea una mayúscula
                } else if i.rangeOfCharacter(from: .uppercaseLetters)  != nil {
                    
                    uppercase = true
                    continue
                    
                    // Comprueba que el caracter actual sea un número
                } else if i.rangeOfCharacter(from: .decimalDigits) != nil {
                    
                    int = true
                    continue
                    
                    // Comprueba que el caracter actual sea un símbolo (que no sea ni una letra ni un número)
                } else if i.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
                    
                    symbol = true
                    continue
                }
            }
            
            // Si todas las variables son true, la contraseña es válida
            if uppercase && lowercase && int && symbol {
                    
                    entry.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                return " "
                
                // si alguna de las variables no es un true, se le dirá al usuario que la contraseña no es correcta
            } else {
                
                return "La contraseña debe tener minúsculas, mayúsculas, números y símbolos"
            }
            
            // si el texto del campo es más corto de 8 caracteres, salta otro error
        } else {
            
            return "la contraseña debe ser mayor de 8 caracteres"
        }
    }
}

// declaración de los caracteres que puede contener un mail antes y despues de la arroba
private let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
private let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
private let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
private let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

// evalua si el String que se le manda tiene los formatos que se van dando en las constantes superiores a esta extensión
extension String {
    func isEmail() -> Bool {
        
        return __emailPredicate.evaluate(with: self)
    }
}
