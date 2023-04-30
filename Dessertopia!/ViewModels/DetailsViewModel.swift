
//  DetailsViewModel.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/26/23.


import Foundation
import SwiftUI

@MainActor
class DetailsViewModel: ObservableObject {
    
    @Published var isPlayButtonTapped = false
    @Published var isButtonTapped = false
    @Published var isErrorShown = false
    @Published var isShowingSheet = false
    @Published var isLoading = false
    
    @Published var dessert: [Dessert] = []
    
    private var networkManager = NetworkManager()
   
    func fetchMealDetailswith(mealId: String) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        
        networkManager.fetchDetails(withId: mealId) { [weak self] result in
            switch result {
            case .success(let dessert):
                
                let desserts = dessert.meals.map {
                    Dessert(idMeal: $0.idMeal,
                            strMeal: $0.strMeal,
                            strInstructions: $0.strInstructions,
                            strMealThumb: $0.strMealThumb,
                            strYoutube: $0.strYoutube,
                            ingredients: $0.ingredients)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [ weak self ] in
                    self?.isLoading = false
                    self?.dessert = desserts
                }
                
            case .failure( _):
                DispatchQueue.main.async { [ weak self ] in
                    self?.isErrorShown = true
                }
            }
        }
    }
}

