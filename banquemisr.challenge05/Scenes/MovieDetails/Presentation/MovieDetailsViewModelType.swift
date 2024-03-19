//
//  MovieDetailsViewModelType.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import Combine

/// Movie DetailsInput & Output
///
typealias MovieDetailsViewModelType = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

/// Movie Details ViewModel Input
///
protocol MovieDetailsViewModelInput {
}

/// Movie Details ViewModel Output
///
protocol MovieDetailsViewModelOutput {
    var movieDetails: MovieDetailsModel { get }
        
    var movieDetailsLoadRelay: PassthroughSubject<Bool, Never> { get }
    var errorRelay: PassthroughSubject<NetworkError, Never> { get }
    
    func getMovieDetails(movieId: String)
}
