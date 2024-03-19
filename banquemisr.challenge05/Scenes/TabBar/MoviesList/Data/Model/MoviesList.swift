//
//  MoviesList.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Foundation

struct MoviesList {
    var movies: [Movie]?
    var nextPage: Int?
    
    init(movies: [Movie]?, nextPage: Int?) {
        self.movies = movies
        self.nextPage = nextPage
    }
}

struct Movie {
    let id: Int?
    let posterPath, releaseDate, title: String?

    init(entity: MoviesEntity) {
        id = entity.id
        posterPath = entity.posterPath
        releaseDate = entity.releaseDate
        title = entity.title
    }
}
