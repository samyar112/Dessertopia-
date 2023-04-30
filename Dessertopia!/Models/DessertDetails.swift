//
//  DessertDetailsModel.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import Foundation

struct MealsResponse: Decodable, Hashable {
    let meals: [Dessert]
}

struct Ingredients: Decodable, Hashable {
    let name: String
    let measure: String
}

struct Dessert: Decodable, Identifiable, Hashable {
    let id = UUID()
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String
    let strYoutube: String
    let ingredients: [Ingredients]?
}
