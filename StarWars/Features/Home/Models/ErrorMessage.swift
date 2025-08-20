//
//  IdentifiableError.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-18.
//

import Foundation


struct ErrorMessage: Identifiable {
    let id = UUID()
    let message: String
}
