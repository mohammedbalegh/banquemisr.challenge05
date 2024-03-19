//
//  MovieDetailsModel.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Foundation

class MovieDetailsModel {
    let backdropPath: String?
    let genres: [String]?
    let id: Int
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let voteAverage: Double?
    let homepage: String?
    
    init(backdropPath: String?, genres: [String]?, id: Int, overview: String?, posterPath: String?, releaseDate: String?, runtime: Int?, title: String?, voteAverage: Double?, homepage: String?) {
        self.backdropPath = backdropPath
        self.genres = genres
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.title = title
        self.voteAverage = voteAverage
        self.homepage = homepage
    }
    
    init() {
        self.backdropPath = nil
        self.genres = nil
        self.id = 0
        self.overview = nil
        self.posterPath = nil
        self.releaseDate = nil
        self.runtime = nil
        self.title = nil
        self.voteAverage = nil
        self.homepage = nil
    }
}
