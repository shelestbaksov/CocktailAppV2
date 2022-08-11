import Foundation

struct Drink: Hashable {
    // Same type, different name
    let name: String
    let recipe: String
    
    // Type is changed
    var isAlcoholic: Bool
    let thumbnailURL: URL?
    let ingredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case strDrink
        case strInstructions
    }
        
    enum AdditionalInfoKeys: String, CodingKey {
        case strAlcoholic
        case strDrinkThumb
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
    }
}

extension Drink: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .strDrink)
        recipe = try values.decode(String.self, forKey: .strInstructions)
        
        let additionalInfo = try decoder.container(keyedBy: AdditionalInfoKeys.self)
        
        // Decoding isAlcoholic
        let strAlcoholicServerValue = try additionalInfo.decode(String.self, forKey: .strAlcoholic)
        isAlcoholic = (strAlcoholicServerValue == "Alcoholic")
        
        // Decoding thumbnailURL
        if let thumbnailURLString = try? additionalInfo.decode(String.self, forKey: .strDrinkThumb) {
            thumbnailURL = URL(string: thumbnailURLString)
        } else {
            thumbnailURL = nil
        }
        
        // Decoding ingredients
        let ingredient1 = try? additionalInfo.decode(String.self, forKey: .strIngredient1)
        let ingredient2 = try? additionalInfo.decode(String.self, forKey: .strIngredient2)
        let ingredient3 = try? additionalInfo.decode(String.self, forKey: .strIngredient3)
        let ingredient4 = try? additionalInfo.decode(String.self, forKey: .strIngredient4)
        let ingredient5 = try? additionalInfo.decode(String.self, forKey: .strIngredient5)
        let ingredient6 = try? additionalInfo.decode(String.self, forKey: .strIngredient6)
        let ingredient7 = try? additionalInfo.decode(String.self, forKey: .strIngredient7)
        let ingredient8 = try? additionalInfo.decode(String.self, forKey: .strIngredient8)
        let ingredient9 = try? additionalInfo.decode(String.self, forKey: .strIngredient9)
        let ingredient10 = try? additionalInfo.decode(String.self, forKey: .strIngredient10)
        let ingredient11 = try? additionalInfo.decode(String.self, forKey: .strIngredient11)
        let ingredient12 = try? additionalInfo.decode(String.self, forKey: .strIngredient12)
        
        let optionalIngredientsArray = [ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6, ingredient7, ingredient8, ingredient9, ingredient10, ingredient11, ingredient12]
        ingredients = optionalIngredientsArray.compactMap({ $0 })
    }
}

extension Drink: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .strDrink)
        try container.encode(recipe, forKey: .strInstructions)
        
        var additionalInfo = encoder.container(keyedBy: AdditionalInfoKeys.self)
        try additionalInfo.encode(isAlcoholic ? "Alcoholic" : "Non-Alcoholic", forKey: .strAlcoholic)
        try additionalInfo.encode(thumbnailURL?.absoluteString, forKey: .strDrinkThumb)
        
        if ingredients.count > 0 {
            try additionalInfo.encode(ingredients[0], forKey: .strIngredient1)
        }
        if ingredients.count > 1 {
            try additionalInfo.encode(ingredients[1], forKey: .strIngredient2)
        }
        if ingredients.count > 2 {
            try additionalInfo.encode(ingredients[2], forKey: .strIngredient3)
        }
        if ingredients.count > 3 {
            try additionalInfo.encode(ingredients[3], forKey: .strIngredient4)
        }
        if ingredients.count > 4 {
            try additionalInfo.encode(ingredients[4], forKey: .strIngredient5)
        }
        if ingredients.count > 5 {
            try additionalInfo.encode(ingredients[5], forKey: .strIngredient6)
        }
        if ingredients.count > 6 {
            try additionalInfo.encode(ingredients[6], forKey: .strIngredient7)
        }
        if ingredients.count > 7 {
            try additionalInfo.encode(ingredients[7], forKey: .strIngredient8)
        }
        if ingredients.count > 8 {
            try additionalInfo.encode(ingredients[8], forKey: .strIngredient9)
        }
        if ingredients.count > 9 {
            try additionalInfo.encode(ingredients[9], forKey: .strIngredient10)
        }
        if ingredients.count > 10 {
            try additionalInfo.encode(ingredients[10], forKey: .strIngredient11)
        }
        if ingredients.count > 11 {
            try additionalInfo.encode(ingredients[11], forKey: .strIngredient12)
        }
    }
}

struct DrinksResponse: Decodable {
    let drinks: [Drink]
}
