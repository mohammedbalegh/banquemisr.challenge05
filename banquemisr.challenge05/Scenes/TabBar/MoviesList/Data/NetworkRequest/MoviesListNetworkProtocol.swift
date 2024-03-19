//
//  MoviesListNetworkProtocol.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Combine

protocol MoviesListNetworkProtocol {
    func getUpcoming(page: String) -> AnyPublisher<MoviesListEntities, NetworkError>
    func getNowPlaying(page: String) -> AnyPublisher<MoviesListEntities, NetworkError>
    func getPopular(page: String) -> AnyPublisher<MoviesListEntities, NetworkError>
}
