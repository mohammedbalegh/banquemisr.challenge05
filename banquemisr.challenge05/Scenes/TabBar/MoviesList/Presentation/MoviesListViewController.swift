//
//  MoviesListViewController.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import UIKit
import Combine

class MoviesListViewController: BaseViewController {

    @IBOutlet private weak var moviesListCollectionView: UICollectionView!
    
    weak var coordinator: TabBarCoordinator?
    
    private let viewModel: MoviesListViewModelType
    private let listType: TabBarPage
    private var refreshControl: UIRefreshControl!
    private var isLoading: Bool = false
    private let itemHeight = 242
    
    private var cancellable = Set<AnyCancellable>()

    init(viewModel: MoviesListViewModelType, listType: TabBarPage) {
        self.viewModel = viewModel
        self.listType = listType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        binding()
        
        getMoviesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScreenTitle()
    }

}

// MARK: - Get Data

extension MoviesListViewController {
    
    private func getMoviesList() {
        switch listType {
        case .nowPlaying:
            viewModel.getNowPlaying()
        case .popular:
            viewModel.getPopular()
        case .upcoming:
            viewModel.getUpcoming()
        }
    }
}

// MARK: - Setup UI

extension MoviesListViewController {
    
    private func setupScreenTitle() {
        if let navigationController = navigationController {
            navigationController.navigationBar.topItem?.title = listType.pageTitleValue
        }
    }
    
    private func setupUI() {
        setupMoviesListCollectionView()
    }
    
    private func setupMoviesListCollectionView() {
        moviesListCollectionView.delegate = self
        moviesListCollectionView.dataSource = self
        
        moviesListCollectionView.register(cellType: MoviesCollectionViewCell.self)
        moviesListCollectionView.addSubview(setupRefreshController())
    }
    
    private func setupRefreshController() -> UIRefreshControl {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        moviesListCollectionView.refreshControl = refreshControl
        return refreshControl
    }
    
    @objc func reload() {
        viewModel.resetPageCount()
        getMoviesList()
     }
}

// MARK: - Binding

extension MoviesListViewController {
    
    private func binding() {
        bindData()
        bindError()
    }
    
    private func bindData() {
        viewModel.moviesListReloadRelay.receive(on: DispatchQueue.main).sink { [weak self] loadingState in
            guard let self else { return }
            startLoadingIndicator(isLoading: loadingState)
            moviesListCollectionView.reloadData()
            moviesListCollectionView.refreshControl?.endRefreshing()
        }.store(in: &cancellable)
    }
    
    private func bindError() {
        viewModel.errorRelay.receive(on: DispatchQueue.main).sink { [weak self] error in
            guard let self else { return }
            showError(error)
        }.store(in: &cancellable)
    }
    
}

// MARK: - Movies list collectionView

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.moviesList.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MoviesCollectionViewCell.self, for: indexPath)
        cell.setupCell(movie: viewModel.moviesList.movies![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 2) - 42, height: 242)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 22, bottom: 24, right: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isScrolledToBottom() && !isLoading {
            isLoading = true
            viewModel.increasePageCount()
            getMoviesList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = viewModel.moviesList.movies?[indexPath.row].id?.string() {
            coordinator?.navigateToMovieDetails(movieId: id)
        }
    }
    
    func isScrolledToBottom() -> Bool {
        guard let collectionView = moviesListCollectionView else { return false }
        let offsetY = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        let height = collectionView.frame.size.height
        return offsetY > contentHeight - height
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if !scrollView.isTracking {
            isLoading = false
        }
    }
    
}
