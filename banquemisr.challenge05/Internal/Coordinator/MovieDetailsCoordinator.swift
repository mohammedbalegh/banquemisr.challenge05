//
//  MovieDetailsCoordinator.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import UIKit

final class MovieDetailsCoordinator: ChildCoordinator {
    
    var navigationController: UINavigationController
    var parentCoordinator: ParentCoordinator?
    
    init(navigationController: UINavigationController) {
      self.navigationController = navigationController
    }
    
    func startChild(movieId: String) {
        let movieDetailsViewModel = MovieDetailsViewModel()
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel, movieId: movieId)
        movieDetailsViewController.coordinator = self
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func coordinatorDidFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
