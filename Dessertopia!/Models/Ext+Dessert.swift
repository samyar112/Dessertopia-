//
//  DessertDetails+Ingredients.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/29/23.
//

import Foundation

//Currently,the API response has some fields which are nil, I've written a custom decoder that excludes nil fields and properly decodes them into an array.

extension Dessert {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDict = try container.decode([String: String?].self)
        
        // Parse ingredients
        var ingredients: [Ingredients] = []
        for index in 1...mealDict.count {
            guard let ingredient = mealDict["strIngredient\(index)"] as? String,
                  let measure = mealDict["strMeasure\(index)"] as? String,
                  !ingredient.isEmpty,
                  !measure.isEmpty else {
                continue
            }
            let ingredientObject = Ingredients(name: ingredient, measure: measure)
            ingredients.append(ingredientObject)
        }
        self.ingredients = ingredients
        
        // Parse other properties
        idMeal = mealDict["idMeal"] as? String ?? ""
        strMeal = mealDict["strMeal"] as? String ?? ""
        strInstructions = mealDict["strInstructions"] as? String ?? ""
        strMealThumb = mealDict["strMealThumb"] as? String ?? ""
        strYoutube = mealDict["strYoutube"] as? String ?? ""
    }
}

