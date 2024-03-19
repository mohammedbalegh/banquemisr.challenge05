//
//  Network.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import Combine

protocol Network {
    func execute<T: Codable>(_ request: RequestBase, model: T.Type) -> AnyPublisher<T, NetworkError>
}

