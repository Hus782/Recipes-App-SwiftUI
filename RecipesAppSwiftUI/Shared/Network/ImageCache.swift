//
//  ImageCache.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import SwiftUI

struct ImageRequestResponse {
    let image: UIImage
    let url: URL
    let cost: Int
}

public class ImageCache {
    
    public static let publicCache = ImageCache()
    private let cachedImages: NSCache<NSURL, UIImage>
    private let client: HTTPClientProtocol
    private let placeHolderImage = UIImage(systemName: "photo")!
    
    init(client: HTTPClientProtocol = HTTPClient(), cache: NSCache<NSURL, UIImage> = .init()) {
        self.client = client
        self.cachedImages = cache
    }
    
    private func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    func load(url: String, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        guard let url = URL(string: url) else {
           DispatchQueue.main.async {
                print("Invalid Image")
               completion(.failure(.responseError))
              //  completion(self.placeHolderImage)
            }
            return
        }
        // Check for a cached image.
        if let cachedImage = image(url: url as NSURL) {
            DispatchQueue.main.async {
                print("Cache hit")
                completion(.success(cachedImage))
            }
            return
        }
        // Go fetch the image.
        client.downloadImage(url: url, completion: {
            [weak self]
            result in
            switch result {
            case .success(let results):
                self?.cachedImages.setObject(results.image, forKey: results.url as NSURL, cost: results.cost)
                DispatchQueue.main.async {
                    completion(.success(results.image))
                }
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.responseError))
                }
            }
        })
    }
}
