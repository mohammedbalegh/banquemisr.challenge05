//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

class MovieDetailsViewModel {
    
    private(set) var movieDetails: MovieDetailsModel = .init()
    
    private let moviesDetailsUseCase: MovieDetailsUseCaseProtocol
    private let cachingImplantation = MovieCaching.shared
    
    var movieDetailsLoadRelay: PassthroughSubject<Bool, Never> = .init()
    var errorRelay: PassthroughSubject<NetworkError, Never> = .init()

    private var cancellable = Set<AnyCancellable>()
    
    init(moviesDetailsUseCase: MovieDetailsUseCaseProtocol = MovieDetailsUseCase()) {
        self.moviesDetailsUseCase = moviesDetailsUseCase
    }
}

// MARK: MovieDetailsViewModelInput

extension MovieDetailsViewModel: MovieDetailsViewModelInput {

}

// MARK: MovieDetailsViewModelOutput
//
extension MovieDetailsViewModel: MovieDetailsViewModelOutput {
    
    func getMovieDetails(movieId: String) {
        movieDetailsLoadRelay.send(true)
        moviesDetailsUseCase.getMovieDetails(movieId: movieId)
            .singleOutput(with: &cancellable, completion: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let details):
                    cachingImplantation.cacheMovie(details)
                    movieDetails = details
                    movieDetailsLoadRelay.send(false)
                case .failure(let error):
                    errorRelay.send(error)
                }
            })
    }

}
