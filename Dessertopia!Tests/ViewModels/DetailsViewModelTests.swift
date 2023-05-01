//
//  ViewModelTests.swift
//  Dessertopia!Tests
//
//  Created by Samir Pandey on 4/30/23.
//

import XCTest
@testable import Dessertopia_

class DetailsViewModelTests: XCTestCase {
    
    var viewModel: DetailsViewModel!
    var mockNetworkService: MockNetworkService!
    var mealId = "1"
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = DetailsViewModel(networkManager: mockNetworkService)
    }
    
    func test_fetchDessertDetails_success() {
        // Given
        mockNetworkService.detailResult = .success(MealsResponse(meals: [
            Dessert(idMeal:"1",
                    strMeal: "LemonPie",
                    strInstructions: "Make it however you like. If its bad then eat it.",
                    strMealThumb: "",
                    strYoutube: "",
                    ingredients: [ Ingredients(name: "Milk", measure: "200ml"),
                                   Ingredients(name: "Oil", measure: "60ml")
                                 ])]))
        
        // When
        viewModel.fetchMealDetailswith(mealId: "1")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.dessert.count, 1)
        }
    }
    
    func test_fetchDesserts_failure() {
        // Given
        mockNetworkService.result = .failure(.invalidResponse)
        let expectation = XCTestExpectation(description: "Fetch desserts with failure")
        
        // When
        viewModel.fetchMealDetailswith(mealId: "1")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            XCTAssertNotNil(self.viewModel.isErrorShown)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
