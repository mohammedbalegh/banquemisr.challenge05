//
//  MockMovieDetails.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohammed Balegh on 18/03/2024.
//

import Combine
@testable import banquemisr_challenge05

class MockMovieDetails: MovieDetailsRepoInterface {
    
    var getMoviesDetailsSuccess = false
    var movieDetails: MovieDetailsModel?
    let jsonReader = JsonReader()
    var genresListResult: [String]?
    
    func getMovieDetails(movieId: String) -> AnyPublisher<MovieDetailsModel, NetworkError> {
        return jsonReader.loadJson(fileName: "MovieDetailsResponse", model: MovieDetailsEntity.self)
            .map({ entity in
                getMoviesDetailsSuccess = true
                var genres: [String] = []
                entity.genres?.forEach({genres.append($0.name ?? "")})
                genresListResult = genres
                let movieDetailsModel = MovieDetailsModel(backdropPath: entity.backdropPath, genres: genres, id: entity.id, overview: entity.overview, posterPath: entity.posterPath, releaseDate: entity.releaseDate, runtime: entity.runtime, title: entity.title, voteAverage: entity.voteAverage, homepage: entity.homepage)
                movieDetails = movieDetailsModel
                return Just(movieDetailsModel)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            })!.eraseToAnyPublisher()
    }
}
