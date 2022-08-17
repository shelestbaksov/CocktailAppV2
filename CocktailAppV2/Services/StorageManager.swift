import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private var favoriteDrinks: Set<Drink> = [] {
        didSet { saveChangedFavoriteDrinks() }
    }
    private let userDefaults = UserDefaults.standard
    private let key = "drinks"
    
    init() {
        if let favoriteDrinksBinaries = userDefaults.value(forKey: key) as? [Data] {
            favoriteDrinks = Set(favoriteDrinksBinaries.compactMap {
                return try? JSONDecoder().decode(Drink.self, from: $0)
            })
        }
    }
    
    func isFavorite(drink: Drink) -> Bool {
        favoriteDrinks.contains(drink)
    }
    
    func addToFavorites(drink: Drink) {
        favoriteDrinks.insert(drink) 
    }
    
    func fetchFavoriteDrinks() -> [Drink] {
        return Array(favoriteDrinks)
    }

    func delete(drink: Drink) {
        favoriteDrinks.remove(drink)
    }

    private func saveChangedFavoriteDrinks() {
        let favoriteDrinksBinaries = favoriteDrinks.compactMap {
            return try? JSONEncoder().encode($0)
        }
        userDefaults.set(favoriteDrinksBinaries, forKey: key)
    }
}
