//
//  PlanetServiceProtocol.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

protocol PlanetServiceProtocol {
    func fetchPlanets() async throws -> [Planet]
}
