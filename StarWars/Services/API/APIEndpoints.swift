//
//  APIEndpoints.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

struct API {
    static let baseURL = "https://swapi.info/api/"
    
    struct Planets {
        static var all: String {
            return baseURL + "planets"
        }
        
    }
}
