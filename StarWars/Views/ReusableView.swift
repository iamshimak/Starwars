//
//  ReusableView.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
