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
    private(set) var hasReachedFinalPage: Bool = false
    
    private var page: Int = 1
    private var maxPlanets: Int = 0
    
    func configure() {}
    
    public func hasReachFinalPlanet(row: Int) -> Bool {
        return planets.value.count - 1 < self.maxPlanets && row == self.planets.value.count - 1
    }
    
    private func addPlanets(response: GetPlanetsResponse) {
        debugPrint("next: \(response.next ?? "nil")")
        
        hasReachedFinalPage = response.next == nil
        
        let newPlanets = response.results.map { PlanetViewModel(model: Planet(response: $0)) }
        let allPlanets = planets.value + newPlanets
        
        page += 1
        maxPlanets = allPlanets.count
        
        planets.accept(allPlanets)
    }
    
    // MARK: - API
    
    public func fetchData() {
        let page = page == 1 ? nil : "\(page)"
        PlanetService.getPlanets(page: page) { [weak self] (result: Result<GetPlanetsResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.addPlanets(response: response)
            case .failure(let error):
                self.onError.accept(error)
            }
        }
    }
}
