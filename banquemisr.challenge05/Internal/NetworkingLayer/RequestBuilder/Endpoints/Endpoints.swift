//
//  Endpoints.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import Foundation

enum Endpoints: RequestBase {
    
    var parameter: [String : String]? {
        switch self {
        case .nowPlaying(let page):
            return ["page": page]
        case .popular(let page):
            return ["page": page]
        case .upcoming(let page):
            return ["page": page]
        case .movieDetails:
            return nil
        }
    }
    
    
    // MARK: - Properties
    case nowPlaying(page: String)
    case popular(page: String)
    case upcoming(page: String)
    case movieDetails(movieId: String)
    
    // MARK: - Path
    var path: String {
        switch self {
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .popular:
            return "/3/movie/popular"
        case .upcoming:
            return "/3/movie/upcoming"
        case .movieDetails(let movieId):
            return "/3/movie/\(movieId)"
        }
    }
}
