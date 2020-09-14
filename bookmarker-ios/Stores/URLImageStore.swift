//
//  URLImageStore.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import Foundation
import Combine
import UIKit

class URLImageStore: ObservableObject {
    @Published var image: UIImage?
    var imageCache = ImageCache.getImageCache()
    
    func loadImage(urlString: String?) {
        //  First attempt to load the image from the cache (assuming it exists)
        if loadImageFromCache(urlString: urlString) {
            return
        }
        loadImageFromURL(urlString: urlString)
    }
    
    func loadImageFromCache(urlString: String?) -> Bool {
        guard let urlString = urlString else { return false }
        guard let cachedImage = imageCache.get(key: urlString) else { return false }
        image = cachedImage
        return true
    }
    
    func loadImageFromURL(urlString: String?) {
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                self.imageCache.set(key: urlString, image: loadedImage)
                self.image = loadedImage
            }
        }
        task.resume()
    }
}
