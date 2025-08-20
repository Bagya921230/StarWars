//
//  Planet.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

import Foundation
import SwiftUI

struct Planet: Identifiable, Codable, Equatable {
    var id: String { url.components(separatedBy: "/").last ?? UUID().uuidString }
    let name: String
    let climate: String
    let orbitalPeriod: String
    let gravity: String
    let imageUrl: String = "https://picsum.photos/200/300"
    let url: String
}
