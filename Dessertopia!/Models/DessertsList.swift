//
//  DessertModel.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import Foundation

struct DessertsList: Codable {
    let meals: [Desserts]
}

struct Desserts: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
