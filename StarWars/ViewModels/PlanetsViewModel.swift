//
//  PlanetsViewModel.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

import RxSwift
import RxCocoa

class PlanetsViewModel {
    
    // MARK: - Output
    let planets: BehaviorRelay<[PlanetViewModel]> = BehaviorRelay(value: [])
    let onError: PublishRelay<Error> = PublishRelay()
    var selectedPlanet: PlanetViewModel? = nil
    
    private var page: Int = 1
    private var maxPlanets: Int = 0
    
    func configure() {}
    
    public func hasReachFinalPlanet(row: Int) -> Bool {
        return planets.value.count - 1 < self.maxPlanets && row == self.planets.value.count - 1
    }
    
    // MARK: - API
    
    func fetchData() {
        let page = page == 1 ? nil : "\(page)"
        PlanetService.getPlanets(page: page) { [weak self] (result: Result<GetPlanetsResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let planets = response.results.map { PlanetViewModel(model: Planet(response: $0)) }
                self.planets.accept(self.planets.value + planets)
                self.page += 1
                self.maxPlanets = response.count
            case .failure(let error):
                self.onError.accept(error)
            }
        }
    }
}
