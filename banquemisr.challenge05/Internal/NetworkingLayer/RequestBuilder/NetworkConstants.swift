//
//  NetworkConstants.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//


import Foundation
extension RequestBase {
    var scheme: String {
        return "https"
    }
    var baseURL: String {
        return "api.themoviedb.org"
    }
    var headers: [String: String]? {
        return ["api_key": "f57f8c2db9977f101211bb6fe782ec90"]
    }
    var method: HTTPMethod {
        return .get
    }
}
