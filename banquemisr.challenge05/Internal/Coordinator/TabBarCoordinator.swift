//
//  TabBarCoordinator.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import UIKit

enum TabBarPage {
    case nowPlaying
    case popular
    case upcoming

    init?(index: Int) {
        switch index {
        case 0:
            self = .nowPlaying
        case 1:
            self = .popular
        case 2:
            self = .upcoming
        default:
            return nil
        }
    }

    var pageTitleValue: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        }
    }

    var pageOrderNumber: Int {
        switch self {
        case .nowPlaying:
            return 0
        case .popular:
            return 1
        case .upcoming:
            return 2
        }
    }
    
    var pageIcon: UIImage? {
        switch self {
        case .nowPlaying:
            return UIImage(systemName: "play.fill")
        case .popular:
            return UIImage(systemName: "star.fill")
        case .upcoming:
            return UIImage(systemName: "calendar")
        }
    }

}

class TabBarCoordinator: NSObject, ParentCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.nowPlaying, .popular, .upcoming]
            .sorted(by: { $0.pageOrderNumber < $1.pageOrderNumber })
        
        let controllers: [UIViewController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.nowPlaying.pageOrderNumber
        tabBarController.tabBar.tintColor = .black
        
        setupTabBarAppearance()
        setupNavBarAppearance()
        
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UIViewController {
        
        let viewModel = MoviesListViewModel()
        let viewController = MoviesListViewController(viewModel: viewModel, listType: page)
        
        viewController.title = page.pageTitleValue
        
        viewController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue,
                                                      image: page.pageIcon,
                                                      tag: page.pageOrderNumber)
        
        viewController.coordinator = self
        
        return viewController
    }
    
    private func setupTabBarAppearance() {
        tabBarController.tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            tabBarController.tabBar.scrollEdgeAppearance = appearance
            tabBarController.tabBar.standardAppearance = appearance
        }
    }
    
    private func setupNavBarAppearance() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .white
        
        navigationController.navigationBar.standardAppearance = navAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navAppearance
    }
}

extension TabBarCoordinator {
    func navigateToMovieDetails(movieId: String) {
        let movieDetailCoordinator = MovieDetailsCoordinator(navigationController: self.navigationController)
        addChild(movieDetailCoordinator)
        movieDetailCoordinator.parentCoordinator = self
        movieDetailCoordinator.startChild(movieId: movieId)
    }
}
