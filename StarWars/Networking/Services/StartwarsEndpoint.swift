//
//  StartwarsEndpoint.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import Foundation

import Alamofire

enum StartwarsEndpoint {
    
    case planets(String?)
    
    var baseURL: String {
        "https://swapi.dev/api/"
    }
    
    var requestURL: URL {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            fatalError("URL for endpoint at \(path) could not be constructed")
        }
                
        return url
    }
    
    var path: String {
        switch self {
        case .planets(let page):
            return page == nil ? "planets" : "planets/?page=\(page!)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .planets:
            return .get
        }
    }
}
