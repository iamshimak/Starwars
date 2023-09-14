//
//  ImageLoader.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

import Alamofire
import AlamofireImage

/**
 Download and cahce images
 */
final class ImageLoader {
    
    public static let instance = ImageLoader()
    private let cache = AutoPurgingImageCache()
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cache.image(withIdentifier: url.absoluteString) {
            completion(.success(image))
            return
        }
        
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                self.cache.add(image, withIdentifier: url.absoluteString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
