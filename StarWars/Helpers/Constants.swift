//
//  Constants.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

struct App {
    static let domain = Bundle.main.bundleIdentifier ?? ""
    
    static var isValidOrientation: Bool {
        UIDevice.current.orientation.isValidInterfaceOrientation
    }
    
    static func orientation() -> Orientation {
        switch UIDevice.current.orientation {
        case .unknown:
            return .portrait
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portrait
        case .landscapeLeft:
            return .landscape
        case .landscapeRight:
            return .landscape
        case .faceUp:
            return .portrait
        case .faceDown:
            return .portrait
        @unknown default:
            return .portrait
        }
    }
}


enum Orientation: Equatable {
    case portrait, landscape
}
