//
//  MockMoviesList.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohammed Balegh on 17/03/2024.
//

import Combine
@testable import banquemisr_challenge05

class MockMoviesList: MoviesListRepositoryInterface {
    
    var getMoviesListSuccess = false
    let jsonReader = JsonReader()
    var moviesListResult: MoviesList?
    var moviesNextPage: Int?
    
    func getNowPlaying(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        return jsonReader.loadJson(fileName: "NowPlayingResponse", model: MoviesListEntities.self)
            .map { self.mapResponseToMoviesList(response: $0) }!
            .eraseToAnyPublisher()
    }
    
    func getUpcoming(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        return jsonReader.loadJson(fileName: "UpComingResponse", model: MoviesListEntities.self)
            .map { self.mapResponseToMoviesList(response: $0) }!
            .eraseToAnyPublisher()
    }
    
    func getPopular(page: String) -> AnyPublisher<MoviesList, NetworkError> {
        return jsonReader.loadJson(fileName: "PopularResponse", model: MoviesListEntities.self)
            .map { self.mapResponseToMoviesList(response: $0) }!
            .eraseToAnyPublisher()
    }
    
    private func mapResponseToMoviesList(response: MoviesListEntities) -> AnyPublisher<MoviesList, NetworkError>  {
        let nextPage = (response.totalPages ?? 0) > (response.page ?? 0) ? (response.page ?? 0) + 1 : nil
        var movies: [Movie] = []
        response.moviesEntity?.forEach { entity in
            movies.append(Movie(entity: entity))
        }
        getMoviesListSuccess = true
        moviesNextPage = nextPage
        moviesListResult = MoviesList(movies: movies, nextPage: nextPage)
        return Just(MoviesList(movies: movies, nextPage: nextPage))
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
