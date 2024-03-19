//
//  MoviesListNetwork.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Combine

struct MoviesListNetwork: MoviesListNetworkProtocol {

    let network: Network
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    func getUpcoming(page: String) -> AnyPublisher<MoviesListEntities, NetworkError> {
        let request = Endpoints.upcoming(page: page)
        let model = MoviesListEntities.self
        let response = network.execute(request, model: model)
        return response
    }
    
    func getNowPlaying(page: String) -> AnyPublisher<MoviesListEntities, NetworkError> {
        let request = Endpoints.nowPlaying(page: page)
        let model = MoviesListEntities.self
        let response = network.execute(request, model: model)
        return response
    }
    
    func getPopular(page: String) -> AnyPublisher<MoviesListEntities, NetworkError> {
        let request = Endpoints.popular(page: page)
        let model = MoviesListEntities.self
        let response = network.execute(request, model: model)
        return response
    }
    
}
