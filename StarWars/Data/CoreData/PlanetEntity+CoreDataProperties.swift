//
//  PlanetEntity+CoreDataProperties.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-19.
//
//

import Foundation
import CoreData


extension PlanetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetEntity> {
        return NSFetchRequest<PlanetEntity>(entityName: "PlanetEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var climate: String?
    @NSManaged public var orbitalPeriod: String?
    @NSManaged public var gravity: String?
    @NSManaged public var url: String?

}

extension PlanetEntity : Identifiable {

}
