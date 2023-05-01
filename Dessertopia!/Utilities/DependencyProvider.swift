//
//  DependencyProvider.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/30/23.
//

import Foundation
import UIKit

struct DependencyProvider {
    static var networkManager: NetworkProtocol {
        return NetworkManager()
    }
    
    static var dessertViewModel: DessertViewModel {
        return DessertViewModel(networkManager: self.networkManager)
    }
    
    static var viewController: DessertViewController {
        return DessertViewController(dessertViewModel: self.dessertViewModel)
    }
}
