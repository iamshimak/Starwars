//
//  PlanetService.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

import Alamofire

final public class PlanetService {
    
    /**
     Get planete API
     */
    class func getPlanets(
        page: String? = nil,
        completion: @escaping (Result<GetPlanetsResponse, Error>) -> Void
    ) {
        AF.request(StartwarsEndpoint.planets(page).requestURL)
            .responseDecodable(of: GetPlanetsResponse.self, completionHandler: { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
}
