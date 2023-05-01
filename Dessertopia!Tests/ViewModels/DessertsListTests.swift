//
//  Tests.swift
//  Dessertopia!Tests
//
//  Created by Samir Pandey on 4/30/23.
//

import Foundation
import XCTest
@testable import Dessertopia_

class DessertsListTests: XCTestCase {
    var viewModel: DessertViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = DessertViewModel(networkManager: mockNetworkService)
    }
    
    func test_fetchDesserts_success() {
        // Given
        mockNetworkService.result = .success(DessertsList(meals: [
            Desserts(strMeal: "KiwiPie 1", strMealThumb: "", idMeal: "1"),
            Desserts(strMeal: "DragonPie 2", strMealThumb: "", idMeal: "2"),
            Desserts(strMeal: "ApplePie 3", strMealThumb: "", idMeal: "3")
            
        ]))
        let expectation = XCTestExpectation(description: "Fetch desserts successfully")
        
        // When
        viewModel.fetchDesserts()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.desserts[0].strMeal, "ApplePie 3")
            XCTAssertEqual(self.viewModel.desserts[1].strMeal, "DragonPie 2")
            XCTAssertEqual(self.viewModel.desserts[2].strMeal, "KiwiPie 1")
            XCTAssertEqual(self.viewModel.desserts.count, 3)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
        func test_fetchDesserts_failure() {
            // Given
            mockNetworkService.result = .failure(.invalidResponse)
            let expectation = XCTestExpectation(description: "Fetch desserts with failure")

            // When
            viewModel.fetchDesserts()

            // Then
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertNotNil(self.viewModel.onErrorMessage != nil)

                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0)
        }
    }
