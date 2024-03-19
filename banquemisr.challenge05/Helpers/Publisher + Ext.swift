//
//  Publisher + Ext.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

extension Publisher where Failure == NetworkError {
    func singleOutput(with bag: inout Set<AnyCancellable>, completion: @escaping (Result<Output, NetworkError>) -> Void) {
        var didReceiveValue = false
        var cancellable: AnyCancellable?
        
        cancellable = sink(receiveCompletion: { receivedCompletion in
            switch receivedCompletion {
            case .finished:
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }, receiveValue: { value in
            
            guard !didReceiveValue else { return }
            didReceiveValue = true
            completion(.success(value))

            cancellable?.cancel()
        })
        
        cancellable?.store(in: &bag)
    }
}
