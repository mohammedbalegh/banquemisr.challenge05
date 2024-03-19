//
//  MoviesListUseCase.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Combine

class MoviesListUseCase: MoviesListUseCaseProtocol {
    
    private let moviesListRepository: MoviesListRepositoryInterface
    
    init(moviesListRepository: MoviesListRepositoryInterface = MoviesListRepository()) {
        self.moviesListRepository = moviesListRepository
    }
    
    func getUpcoming(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        moviesListRepository.getUpcoming(page: page)
    }
    
    func getPopular(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        moviesListRepository.getPopular(page: page)
    }
    
    func getNowPlaying(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        moviesListRepository.getNowPlaying(page: page)
    }
}
