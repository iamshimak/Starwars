//
//  ImageService.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

import Alamofire

final class ImageService {
        
    class func downloadImage(
        url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        AF.download(url).responseURL { response in
            switch response.result {
            case .success(let imagePath):
                guard let image = UIImage(contentsOfFile: imagePath.path) else {
                    return
                }
                
                completion(.success(image))
            case .failure(_):
                debugPrint("download image failed")
            }
        }
    }
}
