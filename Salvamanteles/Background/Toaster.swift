import UIKit

class Toaster {
    
    //Funcion que crea un label con sus especificaciones, la cual llamaremos cuando sea necesario para mostrarinformación puntual al usuario (mas adelante habra que crear clase especifica con esta funcion)
    func showToast(message : String, view: UIView) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height/1.35, width: 300, height: 35))
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: toastLabel.font.fontName, size: 20)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
