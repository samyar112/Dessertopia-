//
//  DessertViewModel.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import UIKit

class DessertViewModel {
    
    let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    //  private var networkManager = NetworkManager()
    var desserts: [Desserts] = [] {
        didSet {
            // Notify when the desserts array is updated
            DispatchQueue.main.async {
                self.didUpdateData?()
            }
        }
    }
    // Closures to update Controller.
    var didUpdateData: (() -> Void)?
    var onErrorMessage: ((NetworkError) -> Void)?
    
    func fetchDesserts() {
        networkManager.fetchDesserts() { [weak self] result in
            switch result {
            case .success(let dessert):
                DispatchQueue.main.async {
                    // to sort the array alphabetically. 
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


