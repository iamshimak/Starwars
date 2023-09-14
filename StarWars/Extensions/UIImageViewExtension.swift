//
//  UIImageViewExtension.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

import RxSwift
import SkeletonView

extension UIImageView {
    
    public func load(from url: URL) {
        showAnimatedGradientSkeleton()
        ImageLoader.instance.loadImage(from: url) { [weak self] (result: Result<UIImage, Error>) in
            self?.hideSkeleton()
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
