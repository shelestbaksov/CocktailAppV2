import UIKit
import AlamofireImage

class DrinkCell: UITableViewCell {
    
    // MARK: - Private state
    
    private var onFavoriteTap: (() -> ())?
    
    // MARK: - UI elements
    
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var cocktailImage: UIImageView!
    @IBOutlet var cocktailNameLabel: UILabel! {
        didSet {
            cocktailImage.contentMode = .scaleAspectFill
            cocktailImage.layer.cornerRadius = cocktailImage.frame.height / 2
        }
    }
       
    // MARK: - Public API
    
    func configure(with drink: Drink, isFavorite: Bool, onFavoriteTap: @escaping () -> ()) {
        let normalHeart = UIImage(named: "fav_heart")
        let filledHeart = UIImage(named: "filled_heart")
        
        if isFavorite {
            favoriteButton.setImage(filledHeart, for: .normal)
            favoriteButton.setImage(normalHeart, for: .selected)
            favoriteButton.setImage(normalHeart, for: .highlighted)
        } else {
            favoriteButton.setImage(normalHeart, for: .normal)
            favoriteButton.setImage(filledHeart, for: .selected)
            favoriteButton.setImage(filledHeart, for: .highlighted)
        }
        
        self.onFavoriteTap = onFavoriteTap
        cocktailNameLabel.text = drink.name
        cocktailImage.image = nil
        if let thumbnailURL = drink.thumbnailURL {
            cocktailImage.af.setImage(withURL: thumbnailURL)
        }
    }

    // MARK: - User input
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        onFavoriteTap?()
    }
}
