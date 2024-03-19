//
//  ImageViewWithLoading.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 15/03/2024.
//

import UIKit

enum imageQualities: String {
    case original
    case poster = "w500"
}

class LoadingImageView: UIImageView {
    private var currentUrlString: String?
    private let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from urlString: String?, imageQuality: imageQualities = .poster) {
        
        guard let urlString else {
            image = UIImage(named: "imdb")
            return
        }
        
        image = nil
        
        let completeUrlString = "https://image.tmdb.org/t/p/\(imageQuality.rawValue)/" + urlString

        
        currentUrlString = urlString
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: completeUrlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("my-secret-key", forHTTPHeaderField: "X-Mashape-Key")
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("Failed to load image from URL: \(urlString)")
                return
            }
            
            self.imageCache.setObject(downloadedImage, forKey: urlString as NSString)
            
            if urlString == self.currentUrlString {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
        }
        
        task.resume()
    }
    
    func cancelLoading() {
        currentUrlString = nil
    }
}
