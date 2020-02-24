import UIKit

class RestCells: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var options: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
