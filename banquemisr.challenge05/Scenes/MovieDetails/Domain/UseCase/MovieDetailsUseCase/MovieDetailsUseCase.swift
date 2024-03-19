//
//  MovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let moviesDetailsRepository: MovieDetailsRepoInterface
    private let cachingImplantation = MovieCaching.shared
    
    private var cancellable = Set<AnyCancellable>()
    
    init(moviesDetailsRepository: MovieDetailsRepoInterface = MovieDetailsRepository()) {
        self.moviesDetailsRepository = moviesDetailsRepository
    }
    
    func getMovieDetails(movieId: String) -> AnyPublisher<MovieDetailsModel, NetworkError> {
        if let cachedMovie = cachingImplantation.getCachedMovie(withID: movieId) {
            return Just(cachedMovie)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return moviesDetailsRepository.getMovieDetails(movieId: movieId)
        }
    }
    
}
