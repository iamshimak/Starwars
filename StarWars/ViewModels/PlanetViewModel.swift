//
//  PlanetViewModel.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

class PlanetViewModel {
    private let model: Planet
    
    init(model: Planet) {
        self.model = model
    }
}

extension PlanetViewModel {
    var planetName: String {
        model.name
    }
    
    var climate: String {
        "Climate: \(model.climate)"
    }
    
    var gravity: String {
        "Gravity: \(model.gravity)"
    }
    
    var orbitalPeriod: String {
        "Orbital Period: \(model.orbitalPeriod)"
    }
    
    var imageUrl: String {
        let name = model.name.replacingOccurrences(of: " ", with: "")
        return "https://picsum.photos/seed/\(name)/500/500"
    }
}
