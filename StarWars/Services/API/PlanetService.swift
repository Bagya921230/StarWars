//
//  PlanetService.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

class PlanetService: PlanetServiceProtocol {
    func fetchPlanets() async throws -> [Planet] {
        let urlString = API.Planets.all
        return try await NetworkManager.shared.performRequest(url: urlString)
    }
    
    
}
