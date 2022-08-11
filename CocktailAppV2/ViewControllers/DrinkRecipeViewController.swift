import UIKit

class DrinkRecipeViewController: UITableViewController {
    
    fileprivate enum TableRow {
        case ingredient(String)
        case recipe(String)
        case image(URL?)
        case title(name: String, isAlcoholic: Bool)
    }
    
    // MARK: - Public API
    
    var drink: Drink! {
        didSet {
            dataSource = makeDataSource(from: drink)
            tableView.reloadData()
        }
    }
    
    // MARK: - Private implementation
    
    private var dataSource: [[TableRow]] = []
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = dataSource[indexPath.section][indexPath.row]
        
        switch element {
        case let .ingredient(ingredientName):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ingredientCell",
                for: indexPath
            ) as! IngredientCell
            cell.configure(with: ingredientName)
            cell.selectionStyle = .none
            return cell
            
        case let .recipe(recipe):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "recipeCell",
                for: indexPath)
            var content = cell.defaultContentConfiguration()
            cell.selectionStyle = .none
            content.text = "Directions: \(recipe)"
            cell.contentConfiguration = content
            return cell
        case let .image(image):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "imageCell",
                for: indexPath
            ) as! ImageCell
            cell.selectionStyle = .none
            cell.configure(with: image)
            return cell
        case .title(name: let name, isAlcoholic: let isAlcoholic):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "descriptionCell", for: indexPath
            )
            var content = cell.defaultContentConfiguration()
            content.text = name
            content.textProperties.font = .boldSystemFont(ofSize: 17)
            content.secondaryText = isAlcoholic ? "🔞" : "non-alcoholic"
            content.secondaryTextProperties.font = .systemFont(ofSize: 17)
            cell.selectionStyle = .none
            cell.contentConfiguration = content
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    // MARK: - Private implementation
    private func makeDataSource(from drink: Drink) -> [[TableRow]] {
        var sections: [[TableRow]] = []
        
        var imageSection: [TableRow] = []
        imageSection.append(TableRow.image(drink.thumbnailURL))
        sections.append(imageSection)
        
        var titleSection: [TableRow] = []
        titleSection.append(TableRow.title(name: drink.name, isAlcoholic: drink.isAlcoholic))
        sections.append(titleSection)
        
        var ingredientsSection: [TableRow] = []
        for ingredient in drink.ingredients {
            ingredientsSection.append(TableRow.ingredient(ingredient))
        }
        sections.append(ingredientsSection)
        
        var recipeSection: [TableRow] = []
        recipeSection.append(TableRow.recipe(drink.recipe))
        sections.append(recipeSection)
        
        return sections
    }
}
