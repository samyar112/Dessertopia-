//
//  DessertViewModel.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import UIKit

class DessertViewModel {
    
    private var networkManager = NetworkManager()
    var desserts: [Desserts] = [] {
        didSet {
            // Notify when the desserts array is updated
            DispatchQueue.main.async {
                self.didUpdateData?()
            }
        }
    }
    
    var didUpdateData: (() -> Void)?
    var onErrorMessage: ((NetworkError) -> Void)?
    
    func fetchData() {
        networkManager.fetchDesserts() { [weak self] result in
            switch result {
            case .success(let dessert):
                DispatchQueue.main.async {
                    self?.desserts = dessert.meals.sorted(by: { $0.strMeal < $1.strMeal })
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorMessage?(error)
                }
            }
        }
    }
}


