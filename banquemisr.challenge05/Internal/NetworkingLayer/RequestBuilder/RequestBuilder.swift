//
//  RequestBuilder.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import Foundation

extension RequestBase {
    
    // MARK: URLRequest Generator
    //
    func asURLRequest() -> URLRequest {
        var component: URLComponents = URLComponents()
        component.scheme = self.scheme
        component.host = self.baseURL
        component.path = self.path

        if let parameter = self.parameter {
            component.queryItems = parameter
                .merging(["api_key": "f57f8c2db9977f101211bb6fe782ec90"], uniquingKeysWith: { (current, _) in current })
                .map { URLQueryItem(name: $0.key, value: $0.value) }
        } else {
            component.queryItems = ["api_key": "f57f8c2db9977f101211bb6fe782ec90"].map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        var urlRequest = URLRequest(url: component.url!)
        urlRequest.httpMethod = self.method.rawValue
        self.headers?.forEach({
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        })
        return urlRequest
    }
    
}
