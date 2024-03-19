//
//  MovieDetailsUseCaseTest.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohammed Balegh on 18/03/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05

final class MovieDetailsUseCaseTest: XCTestCase {
    
    var sut: MovieDetailsUseCase!
    var mock: MockMovieDetails!
    var cancellable: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mock = MockMovieDetails()
        sut = MovieDetailsUseCase(moviesDetailsRepository: mock)
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
        cancellable = nil
    }
    
    // Tests
    func testMovieDetailsCall_With_JsonFile() {
        // Arrange
        let expectations = XCTestExpectation(description: "get movie details")
        _ = mock.getMovieDetails(movieId: "763215")
        guard let movieDetails = mock.movieDetails else { return }
        
        // Act
        sut.getMovieDetails(movieId: "763215")
            .singleOutput(with: &cancellable) {[weak self] result in
                guard let self else { return }
                // Assert
                switch result {
                case .success(let details):
                    XCTAssertTrue(mock.getMoviesDetailsSuccess)
                    XCTAssertEqual(movieDetails.genres?.count, details.genres?.count)
                case .failure(let error):
                    XCTAssertNil(error)
                }
                expectations.fulfill()
            }
    }

}
