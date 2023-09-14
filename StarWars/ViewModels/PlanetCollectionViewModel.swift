//
//  PlanetsViewModel.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

import RxSwift
import RxCocoa

class PlanetCollectionViewModel {
    
    // MARK: - Output
    public let planets: BehaviorRelay<[PlanetViewModel]> = BehaviorRelay(value: [])
    public let onError: PublishRelay<Error> = PublishRelay()
    public var selectedPlanet: PlanetViewModel? = nil
    public private(set) var hasReachedFinalPage: Bool = false
    public private(set) var isLoading: PublishRelay<Bool> = PublishRelay()
    
    private var page: Int = 1
    private var maxPlanets: Int = 0
    
    public func configure() {}
    
    /**
     Validates user is checking the final row
     */
    public func hasReachFinalPlanet(row: Int) -> Bool {
        return planets.value.count - 1 < self.maxPlanets && row == self.planets.value.count - 1
    }
    
    /**
     Add planets from get planets API response to planets
     */
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
    
    /**
     Fetch Data from get planets
     */
    public func fetchData() {
        let page = page == 1 ? nil : "\(page)"
        isLoading.accept(true)
        
        PlanetService.getPlanets(page: page) { [weak self] (result: Result<GetPlanetsResponse, Error>) in
            guard let self = self else { return }
            
            self.isLoading.accept(false)
            
            switch result {
            case .success(let response):
                self.addPlanets(response: response)
            case .failure(let error):
                self.onError.accept(error)
            }
        }
    }
}
