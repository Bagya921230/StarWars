//
//  CoreDataManager.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-20.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context = CoreDataStack.shared.context
    
    private init() {}
    
    func savePlanets(_ planets: [Planet]) {
        context.perform {
            do {
                for planetData in planets {
                    // Fetch request to check for existing planet
                    let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", planetData.id)
                    
                    let existingPlanets = try self.context.fetch(fetchRequest)
                    
                    let planetEntity: PlanetEntity
                    if let existingPlanet = existingPlanets.first {
                        // Update the existing planet
                        planetEntity = existingPlanet
                    } else {
                        // Create a new planet
                        planetEntity = PlanetEntity(context: self.context)
                    }
                    
                    // Update fields
                    planetEntity.id = planetData.id
                    planetEntity.name = planetData.name
                    planetEntity.climate = planetData.climate
                    planetEntity.orbitalPeriod = planetData.orbitalPeriod
                    planetEntity.gravity = planetData.gravity
                    planetEntity.url = planetData.url
                }
                // Save changes to Core Data
                try self.context.save()
            } catch {
                print("Failed to save planets: \(error)")
            }
        }
    }
    
    func fetchPlanets() -> [Planet] {
        let request: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            let results = try context.fetch(request)
            let sortedResults = results.sorted {
                (Int($0.id ?? "") ?? 0) < (Int($1.id ?? "") ?? 0)
            }
            return sortedResults.map { planetEntity in
                return Planet(
                    name: planetEntity.name ?? "",
                    climate: planetEntity.climate ?? "",
                    orbitalPeriod: planetEntity.orbitalPeriod ?? "",
                    gravity: planetEntity.gravity ?? "",
                    url: planetEntity.url ?? ""
                )
            }
        } catch {
            print("Failed to fetch planets: \(error)")
            return []
        }
    }
    
    func clearAllPlanets() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PlanetEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete existing planets: \(error)")
        }
    }
}
