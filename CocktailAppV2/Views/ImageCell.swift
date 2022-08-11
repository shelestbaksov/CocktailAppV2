import UIKit
import AlamofireImage

class ImageCell: UITableViewCell {
    @IBOutlet var drinkImageView: UIImageView! 
    
    func configure(with image: URL?) {
        guard let image = image else { return }
        drinkImageView.af.setImage(withURL: image)
    }
}
