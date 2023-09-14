//
//  GetPlanetsResponse.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

class GetPlanetsResponse: NSObject, Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlanetResponse]
}
