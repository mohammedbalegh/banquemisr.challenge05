//
//  MovieDetailsRepository.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

struct MovieDetailsRepository: MovieDetailsRepoInterface {
    
    private let networkImplementation: MovieDetailsNetworkProtocol
    
    // MARK: - Initializer
    init(networkImplementation: MovieDetailsNetworkProtocol = MovieDetailsNetwork()) {
        self.networkImplementation = networkImplementation
    }
    
    func getMovieDetails(movieId: String) -> AnyPublisher<MovieDetailsModel, NetworkError> {
        return networkImplementation.getMovieDetails(movieId: movieId)
            .map({ entity in
                var genres: [String] = []
                entity.genres?.forEach({genres.append($0.name ?? "")})
                return MovieDetailsModel(backdropPath: entity.backdropPath, genres: genres, id: entity.id, overview: entity.overview, posterPath: entity.posterPath, releaseDate: entity.releaseDate, runtime: entity.runtime, title: entity.title, voteAverage: entity.voteAverage, homepage: entity.homepage)
            })
            .eraseToAnyPublisher()
    }
    
}

