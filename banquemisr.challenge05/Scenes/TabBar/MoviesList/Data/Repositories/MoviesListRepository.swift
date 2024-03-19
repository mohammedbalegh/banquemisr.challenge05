//
//  MoviesListRepositories.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Combine

struct MoviesListRepository: MoviesListRepositoryInterface {
    
    private let networkImplementation: MoviesListNetworkProtocol
    
    // MARK: - Initializer
    init(networkImplementation: MoviesListNetworkProtocol = MoviesListNetwork()) {
        self.networkImplementation = networkImplementation
    }
    
    func getUpcoming(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        return networkImplementation.getUpcoming(page: page)
            .map { self.mapResponseToMoviesList(response: $0) }
            .eraseToAnyPublisher()
    }
    
    func getPopular(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        return networkImplementation.getPopular(page: page)
            .map { self.mapResponseToMoviesList(response: $0) }
            .eraseToAnyPublisher()
    }
    
    func getNowPlaying(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        return networkImplementation.getNowPlaying(page: page)
            .map { self.mapResponseToMoviesList(response: $0) }
            .eraseToAnyPublisher()
    }
    
    private func mapResponseToMoviesList(response: MoviesListEntities) -> MoviesList {
        let nextPage = (response.totalPages ?? 0) > (response.page ?? 0) ? (response.page ?? 0) + 1 : nil
        var movies: [Movie] = []
        response.moviesEntity?.forEach { entity in
            movies.append(Movie(entity: entity))
        }
        return MoviesList(movies: movies, nextPage: nextPage)
    }
}
