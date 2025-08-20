//
//  PlanetListViewModel.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

import CoreData

@MainActor
class PlanetListViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?
    @Published var searchText: String = ""
    
    private var allPlanets: [Planet] = []
    private let planetService: PlanetServiceProtocol
    private let coreDataManager: CoreDataManager
    private var currentPage: Int = 0
    private let itemsPerPage: Int = 10
    
    init(planetService: PlanetServiceProtocol = PlanetService(), coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.planetService = planetService
        self.coreDataManager = coreDataManager
    }
    
    /// Method to load the planet data based on the connectivity status
    func loadPlanets() {
        if NetworkMonitor.shared.isConnected {
            Task { await self.fetchPlanets() }
        } else {
            self.loadPlanetsFromCoreData()
        }
    }
    
    
    /// Method for fetching the data from the planet service
    func fetchPlanets() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        do {
            //Clear core data
            coreDataManager.clearAllPlanets()

            //Reset the array
            self.planets = []
            self.currentPage = 0
            
            //Fetching from API
            let newPlanets = try await planetService.fetchPlanets()
            allPlanets = newPlanets
            
            //Saving to core data
            coreDataManager.savePlanets(newPlanets)
            refreshImageCache()
            
            //Load the paginated results
            loadMorePlanets()
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
    
    /// Method for refreshing the image cache
    func refreshImageCache() {
        for planet in allPlanets {
            if let url = URL(string: planet.imageUrl) {
                ImageLoader.shared.loadImage(from: url, identifier: planet.id, forceRefresh: true) { _ in }
            }
        }
    }
    
    /// Method for paginating the records
    func loadMorePlanets() {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, allPlanets.count)
        
        if startIndex < allPlanets.count {
            let newItems = Array(allPlanets[startIndex..<endIndex])
            planets.append(contentsOf: newItems)
            currentPage += 1
        }
    }
    
    /// Method for filtering the data on searchtext changes
    var filteredPlanets: [Planet] {
        if searchText.isEmpty {
            return planets
        } else {
            return planets.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    /// Method for loading planets from Core data
    private func loadPlanetsFromCoreData() {
        let planets = coreDataManager.fetchPlanets()
        DispatchQueue.main.async {
            self.planets = planets
        }
    }
    
}
