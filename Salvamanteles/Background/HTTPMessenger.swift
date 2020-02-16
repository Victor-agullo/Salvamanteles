//
//  File.swift
//  Salvamanteles
//
//  Created by alumnos on 14/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import Alamofire

class HTTPMessenger {
    
    // recoge la string de contacto con el server y, junto con el fragmento del endpoint,
    // la convierte en una URL válida
    func urlModder(urlEndpoint: String) -> URL {
        let urlString = "http://localhost:8888/salvamanteles/public/index.php/api/"

        let url = URL(string: urlString+urlEndpoint)!
        
        return url
    }
    
    // función que realiza el post
    func post(endpoint: String, params: Any) -> DataRequest{
        
        let url = urlModder(urlEndpoint: endpoint)
        
        let post = Alamofire.request(url, method: .post, parameters: params as? Parameters)
        
        return post
    }
    
    // función que realiza el get con el token en el header
    func get(endpoint: String) -> DataRequest {
        
        let url = urlModder(urlEndpoint: endpoint)
        
        let token = [
            "token" : UserDefaults.standard.value(forKey: "token")!
        ] as! [String:String]
        
        let get = Alamofire.request(url, method: .get, headers: token)

        return get
    }
    
    // guardado del token tras transformar una respuesta json en un diccionario
    func tokenSavior(response: DataResponse<Any>) {
        
        let token = jsonOpener(response: response)
        
        UserDefaults.standard.set(token["token"], forKey: "token")
    }
    
    // abre los json como diccionarios
    func jsonOpener(response: DataResponse<Any>) -> [String: Any] {
        let jsonToken = response.result.value!
        
        let object = jsonToken as! [String: Any]
        
        return object
    }
}
