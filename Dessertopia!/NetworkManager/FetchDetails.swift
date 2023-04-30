//
//  GetDetailsAPI.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//


import Foundation

extension NetworkManager {
    
    func fetchDetails(withId mealId: String, completion: @escaping (Result<MealsResponse, NetworkError>) -> Void) {
        guard let urlString = constructURLString(mealId: mealId),
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
                let detailResponse = try decoder.decode(MealsResponse.self, from: data)
                completion(.success(detailResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func constructURLString(mealId: String) -> String? {
        //        https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
        
        let baseURL = ConstantsAPI.baseURL
        let endpoint = ConstantsAPI.lookupEndpoint
        let queryParam = ConstantsAPI.idQueryParam
        
        let urlString = baseURL + endpoint + "?" + queryParam + "=" + mealId
        
        return urlString
    }
}

