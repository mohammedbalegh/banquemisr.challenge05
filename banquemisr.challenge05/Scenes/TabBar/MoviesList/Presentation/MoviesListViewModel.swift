//
//  MoviesListViewModel.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import Combine

class MoviesListViewModel {
    
    private let moviesListUseCase: MoviesListUseCaseProtocol
    
    private(set) var moviesList: MoviesList = .init(movies: [], nextPage: nil)
        
    var moviesListReloadRelay: PassthroughSubject<Bool, Never> = .init()
    var errorRelay: PassthroughSubject<NetworkError, Never> = .init()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(moviesListUseCase: MoviesListUseCaseProtocol = MoviesListUseCase()) {
        self.moviesListUseCase = moviesListUseCase
    }
}

// MARK: MoviesListViewModelInput

extension MoviesListViewModel: MoviesListViewModelInput {    
    
    func resetPageCount() {
        moviesList.nextPage = 1
    }
    
    func increasePageCount() {
        guard (moviesList.nextPage != nil) else { return }
        moviesList.nextPage! += 1
    }
    
}

// MARK: MoviesListViewModelOutput
//
extension MoviesListViewModel: MoviesListViewModelOutput {
    
    func getUpcoming() {
        let page = moviesList.nextPage?.string() ?? "1"

        moviesListReloadRelay.send(true)

        moviesListUseCase.getUpcoming(page: page)
            .singleOutput(with: &cancellable, completion: { [weak self] result in
                guard let self else { return}
                
                switch result {
                case .success(let movies):
                    updateMoviesList(moviesList: movies, page: Int(page) ?? 1)
                case .failure(let error):
                    errorRelay.send(error)
                }
                moviesListReloadRelay.send(false)
            })
        
    }
    
    func getPopular() {
        let page = moviesList.nextPage?.string() ?? "1"
        
        moviesListReloadRelay.send(true)

        moviesListUseCase.getPopular(page: page)
            .singleOutput(with: &cancellable, completion: { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    updateMoviesList(moviesList: movies, page: Int(page) ?? 1)
                case .failure(let error):
                    errorRelay.send(error)
                }
                moviesListReloadRelay.send(false)
            })
    }
    
    func getNowPlaying() {
        let page = moviesList.nextPage?.string() ?? "1"

        moviesListReloadRelay.send(true)
        
        moviesListUseCase.getNowPlaying(page: page)
            .singleOutput(with: &cancellable, completion: { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    updateMoviesList(moviesList: movies, page: Int(page) ?? 1)
                case .failure(let error):
                    errorRelay.send(error)
                }
                moviesListReloadRelay.send(false)
            })
    }
    
    private func updateMoviesList(moviesList: MoviesList, page: Int) {
        if page == 1 {
            self.moviesList = moviesList
        } else {
            self.moviesList.movies?.append(contentsOf: moviesList.movies ?? [])
            self.moviesList.nextPage = page
        }
    }
}
