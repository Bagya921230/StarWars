//
//  NetworkManager.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

import Foundation

//Network related errors
enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case custom(String)
}

//HTTP Methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//Responsible for making network requests and decoding result JSON
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //Generic method to perform network requests
    func performRequest<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        body: Data? = nil
    ) async throws -> T {
        
        //URL validation
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        //Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        //Perform request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.requestFailed
        }
        
        //Decode response
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {

            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingFailed
        }
    }
}
