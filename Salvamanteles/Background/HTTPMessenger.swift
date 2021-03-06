import UIKit
import Alamofire

class HTTPMessenger: UIViewController {

    
    // recoge la string de contacto con el server y, junto con el fragmento del endpoint,
    // la convierte en una URL válida
    func urlModder(urlEndpoint: String) -> URL {
        
        //este es el de javi:
        //let urlString = "http://127.0.0.1/salvamanteles-master/public/index.php/api/"
        
        // este es el de victor:
        let urlString = "http://localhost:8888/salvamanteles/public/index.php/api/"
        
        // este es el de diego:
        //let urlString = "http://localhost:8888/Diego/salvamanteles_dos/public/index.php/api/"
        
        let url = URL(string: urlString+urlEndpoint)!
        
        return url
    }
    
    // función que realiza el post
    func post(endpoint: String, params: Any) -> DataRequest{
        
        var doing = true
        
        
        let url = urlModder(urlEndpoint: endpoint)
        
        let token = [
            "token" : UserDefaults.standard.value(forKey: "token")!
            ] as! [String:String]
        
        let post = Alamofire.request(url, method: .post, parameters: params as? Parameters, headers: token)
        
        while (doing) {
            if post.response != nil {
                doing = false
            }
            
        }
        
        return post
    }
    
    // función que realiza el post sin token
    func post_without_token(endpoint: String, params: Any) -> DataRequest{
        
        
        let url = urlModder(urlEndpoint: endpoint)
        
        let post = Alamofire.request(url, method: .post, parameters: params as? Parameters)
        
        return post
    }
    
    // función que realiza el get con el token en el header
    func get(endpoint: String) -> DataRequest {
        
        var doing = true
        
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
    
    // hace un post, cambia de vista si su respuesta es afirmativa y guarda el user si es un registro
    func viewJumper(parameters: Any, uri: String, view: UIView, completion: @escaping (Bool) -> Void ) {
        
        // se realiza el post
        let hadConnected = HTTPMessenger.init().post_without_token(endpoint: uri, params: parameters)
        
        // respuesta del server
        hadConnected.responseJSON { response in
            
            switch (response.response?.statusCode) {
                
            case 200:
                // guarda el usuario en defaults
                UserDefaults.standard.set(parameters, forKey: "user")
                HTTPMessenger.init().tokenSavior(response: response)
                completion(true)
                break
                
            case 401:
                var JSONtoString = response.result.value as! [String:Any]
                let errorFromJSON = JSONtoString["message"] as! String
                Toaster.init().showToast(message: errorFromJSON, view: view)
                break
                
            case .none:
                let errorConection = "Sin conexión a la base de datos"
                Toaster.init().showToast(message: errorConection, view: view)
                break
                
            case .some(_):
                break
                
            }
        }
    }
}
