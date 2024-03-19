//
//  MovieDetailsNetwork.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

struct MovieDetailsNetwork: MovieDetailsNetworkProtocol {
    
    let network: Network
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    func getMovieDetails(movieId: String) -> AnyPublisher<MovieDetailsEntity, NetworkError> {
        let request = Endpoints.movieDetails(movieId: movieId)
        let model = MovieDetailsEntity.self
        let response = network.execute(request, model: model)
        return response
    }
    
}
