//
//  NetworkError.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import Foundation

struct NetworkError: LocalizedError, Decodable {
    var message: String?
    var specificError: DefaultErrors?
    
    init(errorType: DefaultErrors) {
        self.specificError = errorType
    }
}


enum DefaultErrors: Decodable {
    case noConnection
    case invalidResponse
    case serverError
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Unfortunately Server error!, try again later"
        case .noConnection:
            return "Check your internet connection"
        case .unknownError:
            return "Unfortunately, SomeThing went wrong"
        case .invalidResponse:
            return "There is error occurred , try again later"
        case .decodingError:
            return "Failed to decoded data received from server"
        }
    }
}

