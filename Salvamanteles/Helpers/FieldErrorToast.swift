
import UIKit

class WrongFieldError: UILabel {

func showToast(message : String) {
    let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 150, y: self.frame.size.height/1.35, width: 300, height: 35))
    toastLabel.textColor = UIColor.red
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: toastLabel.font.fontName, size: 20)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.clipsToBounds  =  true
    self.addSubview(toastLabel)
    UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
}
