import UIKit

class IngredientCell: UITableViewCell {
    @IBOutlet var ingredientLabel: UILabel!
    
    func configure(with ingredient: String) {
        ingredientLabel.text = ingredient
    }
}
