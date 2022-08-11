import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var drinkSearchBar: UISearchBar!
    
    private let networkManager = NetworkManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let drinkListVC = segue.destination as? DrinkListViewController, let drinks = sender as? [Drink] {
            drinkListVC.drinks = drinks
            drinkListVC.storageManager = StorageManager.shared
        }
    }
    
    @IBAction func searchButtonPressed() {
        if let searchTerm = drinkSearchBar.text, !searchTerm.isEmpty {
            networkManager.searchDrinkRecepies(searchTerm: searchTerm) { [weak self] result in
                switch result {
                case let .success(drinks):
                    self?.performSegue(withIdentifier: "showResults", sender: drinks)
                case .failure(_):
                    DispatchQueue.main.async {
                    self?.showAlert(
                        title: "Sorry",
                        message: "Couldn't find the drink. Try another",
                        onOkTap: nil)
                    }
                }
            }
        } else {
            showAlert(
                title: "Attention",
                message: "Search field is empty",
                onOkTap: nil
            )
        }
    }
}

extension SearchViewController {
    private func showAlert(
        title: String,
        message: String,
        onOkTap: ((UIAlertAction) -> ())? = nil)
    {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: onOkTap)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

