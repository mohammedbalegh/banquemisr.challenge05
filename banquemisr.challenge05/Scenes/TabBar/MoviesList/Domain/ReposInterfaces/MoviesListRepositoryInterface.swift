//
//  MoviesListRepositoryInterface.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Combine

protocol MoviesListRepositoryInterface {
    func getUpcoming(page: String) -> AnyPublisher<MoviesList, NetworkError>
    func getNowPlaying(page: String) -> AnyPublisher<MoviesList, NetworkError>
    func getPopular(page: String) -> AnyPublisher<MoviesList, NetworkError>
}
