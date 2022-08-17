import UIKit

class DrinkListViewController: UITableViewController {
    
    var storageManager: StorageManager!
    var onFavoritesChanged: (() -> ())?
    
    var drinks = [Drink]() { didSet { tableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkCell
        let drink = drinks[indexPath.row]
        let drinkIsFavorite = storageManager.isFavorite(drink: drink)
        cell.configure(with: drink, isFavorite: drinkIsFavorite, onFavoriteTap: { [weak self, drink] in
            if drinkIsFavorite {
                self?.storageManager.delete(drink: drink)
            } else {
                self?.storageManager.addToFavorites(drink: drink)
            }
            self?.onFavoritesChanged?()
            tableView.reloadRows(at: [indexPath], with: .none)
        })
        return cell
    }
    
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let drinkRecipeVC = segue.destination as? DrinkRecipeViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let drink = drinks[indexPath.row]
        drinkRecipeVC.drink = drink
    }
}
