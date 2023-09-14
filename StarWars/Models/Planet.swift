//
//  Planet.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

class Planet: NSObject, Codable {
    
    let climate: String
    let name: String
    let orbitalPeriod: Int
    let gravity: String
    
    init(climate: String, name: String, orbitalPeriod: Int, gravity: String) {
        self.climate = climate
        self.name = name
        self.orbitalPeriod = orbitalPeriod
        self.gravity = gravity
    }
    
    init(response: PlanetResponse) {
        self.climate = response.climate
        self.name = response.name
        self.orbitalPeriod = Int(response.orbital_period) ?? 0
        self.gravity = response.gravity
    }
}
