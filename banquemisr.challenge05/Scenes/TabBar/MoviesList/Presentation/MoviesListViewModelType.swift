//
//  MoviesListViewModelType.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import Combine

/// Movies List Input & Output
///
typealias MoviesListViewModelType = MoviesListViewModelInput & MoviesListViewModelOutput

/// Movies List ViewModel Input
///
protocol MoviesListViewModelInput {
    func increasePageCount()
    func resetPageCount()
}

/// Movies List ViewModel Output
///
protocol MoviesListViewModelOutput {
    var moviesList: MoviesList {get}
    
    var moviesListReloadRelay: PassthroughSubject<Bool, Never> { get }
    var errorRelay: PassthroughSubject<NetworkError, Never> { get }
        
    func getNowPlaying()
    func getPopular()
    func getUpcoming()
}
