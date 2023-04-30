//
//  NetworkManager.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import Foundation

class NetworkManager: NetworkProtocol {
    
    func fetchDesserts(_ completion: @escaping (Result<DessertsList, NetworkError>) -> Void) {
        guard let urlString = createURLString(),
              let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == httpStatus.success else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dessert = try decoder.decode(DessertsList.self, from: data)
                completion(.success(dessert))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func createURLString() -> String? {
        let baseURL = ConstantsAPI.baseURL
        let endpoint = ConstantsAPI.filterEndpoint
        let queryParam = ConstantsAPI.categoryQueryParam
        let categoryValue = ConstantsAPI.categoryDessertValue
        
        let urlString = baseURL + endpoint + "?" + queryParam + "=" + categoryValue
        
        return urlString
    }
}
