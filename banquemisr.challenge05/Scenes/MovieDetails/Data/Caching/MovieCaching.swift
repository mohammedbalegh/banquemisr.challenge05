//
//  MovieCaching.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 17/03/2024.
//

import Foundation

class MovieCaching {
    
    static let shared = MovieCaching()

    private let cache = NSCache<NSNumber, MovieDetailsModel>()

    func cacheMovie(_ movie: MovieDetailsModel) {
        cache.setObject(movie, forKey: NSNumber(value: Int(movie.id)))
    }

    func getCachedMovie(withID id: String) -> MovieDetailsModel? {
        let object = cache.object(forKey: NSNumber(value: Int(id)!))
        return object
    }
    
}
