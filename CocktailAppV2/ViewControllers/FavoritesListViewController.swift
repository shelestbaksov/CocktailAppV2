import UIKit

class FavoritesListViewController: UIViewController {

    private var storageManager: StorageManager = StorageManager.shared
    private weak var listVC: DrinkListViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refetchFavorites()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let list = segue.destination as? DrinkListViewController {
            list.storageManager = StorageManager.shared
            list.drinks = storageManager.fetchFavoriteDrinks()
            list.onFavoritesChanged = { [weak self] in
                self?.refetchFavorites()
            }
            self.listVC = list
        }
    }
    
    private func refetchFavorites() {
        listVC?.drinks = storageManager.fetchFavoriteDrinks()
    }
}
