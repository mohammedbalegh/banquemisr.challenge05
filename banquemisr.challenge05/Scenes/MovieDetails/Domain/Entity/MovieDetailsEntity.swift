//
//  MovieDetailsEntity.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Foundation

struct MovieDetailsEntity: Codable {
    let backdropPath: String?
    let genres: [GenreEntity]?
    let id: Int
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let voteAverage: Double?
    let homepage: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case overview, homepage
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
    }
}
