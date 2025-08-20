//
//  PlanetDetailView.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                AsyncImageView(url: URL(string: planet.imageUrl), identifier: planet.id)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(planet.name).font(.largeTitle).fontWeight(.bold)
                    VStack {
                        DetailItemView(label: LocalizedStringKey("orbitalPeriod_label"), value: "\(planet.orbitalPeriod)")
                        DetailItemView(label: LocalizedStringKey("gravity_label"), value: "\(planet.gravity)")
                    }.padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }.padding()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailItemView: View {
    var label: LocalizedStringKey
    var value: String
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(Color.gray)
        }.padding(3)
    }
}
