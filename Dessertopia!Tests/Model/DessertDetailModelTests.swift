//
//  DessertDetailModelTests.swift
//  Dessertopia!Tests
//
//  Created by Samir Pandey on 4/30/23.
//

import XCTest
@testable import Dessertopia_

final class DessertDetailModelTests: XCTestCase {
    
    func test_DessertModel() throws {
        let mockData = """
            {
                "meals": [
                    {
                        "idMeal": "53049",
                        "strMeal": "Apam balik",
                        "strDrinkAlternate": null,
                        "strCategory": "Dessert",
                        "strArea": "Malaysian",
                        "strInstructions": "Mix.",
                        "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                        "strTags": null,
                        "strYoutube": "https://www.youtube.com/watch?v=6R8ffRRJcrg",
                        "strIngredient1": "Milk",
                        "strIngredient2": "Oil",
                        "strIngredient3": "Eggs",
                        "strIngredient4": "Flour",
                        "strIngredient5": "Baking Powder",
                        "strIngredient6": "Salt",
                        "strIngredient7": "Unsalted Butter",
                        "strIngredient8": "Sugar",
                        "strIngredient9": "Peanut Butter",
                        "strIngredient10": "",
                        "strIngredient11": "",
                        "strIngredient12": "",
                        "strMeasure1": "200ml",
                        "strMeasure2": "60ml",
                        "strMeasure3": "2",
                        "strMeasure4": "1600g",
                        "strMeasure5": "3 tsp",
                        "strMeasure6": "1/2 tsp",
                        "strMeasure7": "25g",
                        "strMeasure8": "45g",
                        "strMeasure9": "3 tbs",
                        "strMeasure10": " ",
                        "strMeasure11": " ",
                        "strMeasure12": " ",
                        "strSource": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                        "strImageSource": null,
                        "strCreativeCommonsConfirmed": null,
                        "dateModified": null
                    }
                ]
            }
        """.data(using: .utf8)!
        // when
        let decoder = JSONDecoder()
        let dessertsList = try decoder.decode(MealsResponse.self, from: mockData)
    
        // then
        XCTAssertEqual(dessertsList.meals.count, 1)
    
        let dessert = dessertsList.meals.first!
        XCTAssertEqual(dessert.idMeal, "53049")
        XCTAssertEqual(dessert.strMeal, "Apam balik")
        XCTAssertEqual(dessert.strMealThumb, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    
        XCTAssertEqual(dessert.ingredients!.count, 9)
    
    }

    func test_IngredientsParsing() {
        // Given
        let mealDict: [String: Any] = [
            "strIngredient1": "Milk",
            "strMeasure1": "200ml",
            "strIngredient2": "Oil",
            "strMeasure2": "60ml",
            "strIngredient3": "",
            "strMeasure3": "",
            "strIngredient4": "Flour",
            "strMeasure4": "1600g",
            "strIngredient5": "Flour",
            "strMeasure5": "1600g",
            "strIngredient7": "",
            "strMeasure7": "",
            "strIngredient8": "Bread",
            "strMeasure8": "1600g",
            "strIngredient6": "",
            "strMeasure6": ""
        ]
        
        // When
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
        
        // Then
        XCTAssertEqual(ingredients.count, 5)
        XCTAssertEqual(ingredients[0].name, "Milk")
        XCTAssertEqual(ingredients[0].measure, "200ml")
        XCTAssertEqual(ingredients[1].name, "Oil")
        XCTAssertEqual(ingredients[1].measure, "60ml")
        XCTAssertEqual(ingredients[2].name, "Flour")
        XCTAssertEqual(ingredients[2].measure, "1600g")
        XCTAssertEqual(ingredients[3].name, "Flour")
        XCTAssertEqual(ingredients[3].measure, "1600g")
        XCTAssertEqual(ingredients[4].name, "Bread")
        XCTAssertEqual(ingredients[4].measure, "1600g")
    }

}

