//
//  NetworkManaging.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import Foundation

protocol NetworkProtocol {
    func fetchDesserts(_ completion: @escaping (Result<DessertsList, NetworkError>) -> Void)
    func fetchDetails(withId mealId: String, completion: @escaping (Result<MealsResponse, NetworkError>) -> Void)
}
