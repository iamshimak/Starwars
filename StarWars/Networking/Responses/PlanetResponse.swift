//
//  PlanetResponse.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

class PlanetResponse: NSObject, Codable {
    let climate: String
    let name: String
    let orbital_period: String
    let gravity: String
}
