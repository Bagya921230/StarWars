//
//  PlanetListView.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

import SwiftUI

struct PlanetListView: View {
    
    @StateObject private var viewModel = PlanetListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredPlanets) { planet in
                    NavigationLink(destination: PlanetDetailView(planet: planet)) {
                        HStack {
                            AsyncImageView(url: URL(string: planet.imageUrl), identifier: planet.id)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(planet.name)
                                Text(planet.climate).foregroundColor(.gray)
                            }.padding(10)
                            
                            Spacer()
                        }
                    }.onAppear {
                        if planet == viewModel.planets.last {
                            viewModel.loadMorePlanets()
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle(LocalizedStringKey("home_title"))
            .searchable(text: $viewModel.searchText, prompt: LocalizedStringKey("search_label"))
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text(LocalizedStringKey("error_label")), message: Text(error.message), dismissButton: .default(Text(LocalizedStringKey("ok_label"))))
            }
            .onAppear {
                if viewModel.planets.isEmpty {
                    viewModel.loadPlanets()
                }
            }
            .refreshable {
                if NetworkMonitor.shared.isConnected {
                    await viewModel.fetchPlanets()
                }
            }
        }
    }
}

