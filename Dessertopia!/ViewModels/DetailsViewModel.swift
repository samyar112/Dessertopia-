
//  DetailsViewModel.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.


import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject {
    
    @Published var isButtonTapped = false
    @Published var isErrorShown = false
    @Published var isLoading = false
    
    @Published var dessert: [Dessert] = []
    
    var flattenedIngredients: [Ingredients] {
            dessert.flatMap { $0.ingredients }
        }
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMealDetailswith(mealId: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.isLoading = true
        }
        
        networkManager.fetchDetails(withId: mealId) { [weak self] result in
            switch result {
            case .success(let dessert):
                // used map to transform only the array that's needed.
                let desserts = dessert.meals.map {
                    Dessert(idMeal: $0.idMeal,
                            strMeal: $0.strMeal,
                            strInstructions: $0.strInstructions,
                            strMealThumb: $0.strMealThumb,
                            strYoutube: $0.strYoutube,
                            ingredients: $0.ingredients)
                }
                //delayed the call for loading indicator for easy user experience. 
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [ weak self ] in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.dessert = desserts
                }
                
            case .failure( _):
                DispatchQueue.main.async { [ weak self ] in
                    guard let self = self else { return }
                    self.isErrorShown = true
                }
            }
        }
    }
}

