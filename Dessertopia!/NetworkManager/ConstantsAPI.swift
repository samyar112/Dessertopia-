//
//  ConstantsAPI.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import Foundation

enum ConstantsAPI {
    // constants utilized to create URL components.
    static let  baseURL = "https://www.themealdb.com/api/json/v1/1"
    static let filterEndpoint = "/filter.php"
    static let lookupEndpoint = "/lookup.php"
    static let categoryQueryParam = "c"
    static let idQueryParam = "i"
    static let categoryDessertValue = "Dessert"
}

enum httpStatus {
    static let  success = 200
}

