//
//  MockNetworkService.swift
//  Dessertopia!Tests
//
//  Created by Samir Pandey on 4/30/23.
//
@testable import Dessertopia_
import Foundation

final class MockNetworkService: NetworkProtocol {

        var result: Result<DessertsList, NetworkError>
        var detailResult: Result<MealsResponse, NetworkError>
        
        init(result: Result<DessertsList, NetworkError> = .failure(.invalidResponse), detailResult: Result<MealsResponse, NetworkError> = .failure(.invalidResponse)) {
            self.result = result
            self.detailResult = detailResult
        }
        
        func fetchDesserts(_ completion: @escaping (Result<DessertsList, NetworkError>) -> Void) {
            completion(result)
        }
        
        func fetchDetails(withId mealId: String, completion: @escaping (Result<MealsResponse, NetworkError>) -> Void) {
            completion(detailResult)
        }
    }





