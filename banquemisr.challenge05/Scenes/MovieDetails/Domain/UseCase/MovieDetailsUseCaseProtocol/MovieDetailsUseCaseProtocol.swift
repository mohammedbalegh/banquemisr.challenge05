//
//  MovieDetailsUseCaseProtocol.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

protocol MovieDetailsUseCaseProtocol {
    func getMovieDetails(movieId: String) -> AnyPublisher<MovieDetailsModel, NetworkError>
}
