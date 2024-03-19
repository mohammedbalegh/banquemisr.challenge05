//
//  MoviesListUseCaseTest.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohammed Balegh on 17/03/2024.
//

import XCTest
import Combine
@testable import banquemisr_challenge05

class MoviesListUseCaseTest: XCTestCase {
    
    var sut: MoviesListUseCase!
    var mock: MockMoviesList!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        mock = MockMoviesList()
        sut = MoviesListUseCase(moviesListRepository: mock)
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
        cancellable = nil
    }
    
    // MARK: - Tests
    
    func testUpcomingApiCall_With_JsonFile() {
        // Arrange
        let expectation = XCTestExpectation(description: "get Upcoming done")
        let currentPage = 1
        _ = mock.getUpcoming(page: currentPage.string())
        guard let result = mock.moviesListResult else { return }
        // Act
        sut.getUpcoming(page: currentPage.string())
            .singleOutput(with: &cancellable, completion: { [weak self] value in
                guard let self else { return }
                switch value {
                case .success(let response):
                    // Assert
                    XCTAssertTrue(mock.getMoviesListSuccess)
                    XCTAssertEqual(mock.moviesNextPage, currentPage + 1)
                    XCTAssertEqual(response.movies?.count, result.movies?.count)
                case .failure(let error):
                    XCTAssertNil(error)
                }
                expectation.fulfill()
            })
    }
    
    func testPopularApiCall_WhenIsLastPage_With_JsonFile() {
        // Arrange
        let expectation = XCTestExpectation(description: "get Popular done")
        _ = mock.getPopular(page: "1")
        guard let result = mock.moviesListResult else { return }
        // Act
        sut.getPopular(page: "1")
            .singleOutput(with: &cancellable, completion: { [weak self] value in
                guard let self else {return}
                switch value {
                case .success(let response):
                    // Assert
                    XCTAssertTrue(self.mock.getMoviesListSuccess)
                    XCTAssertNil(self.mock.moviesNextPage)
                    XCTAssertEqual(response.movies?.count, result.movies?.count)
                case .failure(let error):
                    XCTAssertNil(error)
                }
                expectation.fulfill()
            })
    }
    
    func testNowPlayingApiCall_With_JsonFile() {
        // Arrange
        let expectation = XCTestExpectation(description: "get Now playing done")
        _ = mock.getNowPlaying(page: "1")
        guard let result = mock.moviesListResult else {return}
        // Act
        sut.getNowPlaying(page: "1")
            .singleOutput(with: &cancellable, completion: { [weak self] value in
                guard let self else {return}
                switch value {
                case .success(let response):
                    // Assert
                    XCTAssertTrue(self.mock.getMoviesListSuccess)
                    XCTAssertEqual(response.movies?.count, result.movies?.count)
                case .failure(let error):
                    XCTAssertNil(error)
                }
                expectation.fulfill()
            })
    }
    
}
