import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    func searchDrinkRecepies(searchTerm: String, completion: @escaping (Result<[Drink], Error>) -> ()) {
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchTerm)") else {
            completion(.failure(NetworkError.noData))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let drinksResponse = try JSONDecoder().decode(DrinksResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(drinksResponse.drinks))
                }
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
