//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import UIKit
import Combine

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet private weak var backgroundImage: LoadingImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var moviePosterImage: LoadingImageView!
    @IBOutlet private weak var genresCollectionView: UICollectionView!
    
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var runTimeLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var posterImageContainerView: UIView!
    @IBOutlet private weak var mainInfoContainerView: UIView!
    
    
    private let viewModel: MovieDetailsViewModelType
    private let movieId: String
    
    weak var coordinator: MovieDetailsCoordinator?
    
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: MovieDetailsViewModelType, movieId: String) {
        self.viewModel = viewModel
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        getMoviesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil
        {
            coordinator?.coordinatorDidFinish()
        }
    }
}

// MARK: - Get Data

extension MovieDetailsViewController {
    
    private func getMoviesList() {
        viewModel.getMovieDetails(movieId: movieId)
    }
    
}

// MARK: - Setup UI

extension MovieDetailsViewController {
    
    private func setupUI() {
        setupMoviesListCollectionView()
        setupImages()
        setupLabels()
        setupShadow()
    }
    
    private func setupImages() {
        backgroundImage.loadImage(from: viewModel.movieDetails.backdropPath, imageQuality: .original)
        moviePosterImage.loadImage(from: viewModel.movieDetails.posterPath)
    }
    
    private func setupLabels() {
        movieNameLabel.text = viewModel.movieDetails.title
        movieDescriptionLabel.text = viewModel.movieDetails.overview
        releaseDateLabel.text = viewModel.movieDetails.releaseDate
        runTimeLabel.text = viewModel.movieDetails.runtime?.string()
        urlLabel.text = viewModel.movieDetails.homepage
        
        setupLinkLabelTap()
        setupRatingLabel()
    }
    
    private func setupRatingLabel() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow)
        attachment.image?.withTintColor(.systemYellow)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: viewModel.movieDetails.voteAverage?.rounded(toPlaces: 1).string() ?? "" + " ")
        myString.append(attachmentString)
        movieRatingLabel.attributedText = myString
    }
    
    private func setupMoviesListCollectionView() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        
        genresCollectionView.register(cellType: GenresCollectionViewCell.self)
    }
    
    private func setupLinkLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.linkLabelTapped(_:)))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(labelTap)
    }
    
    @objc func linkLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: viewModel.movieDetails.homepage ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    private func setupShadow() {
        mainInfoContainerView.addShadow()
        
        posterImageContainerView.addShadow()
    }
}

// MARK: - Binding

extension MovieDetailsViewController {
    
    private func binding() {
        bindData()
        bindError()
    }
    
    private func bindData() {
        viewModel.movieDetailsLoadRelay.receive(on: DispatchQueue.main).sink { [weak self] loadingState in
            guard let self else { return }
            startLoadingIndicator(isLoading: loadingState)
            genresCollectionView.reloadData()
            setupUI()
        }.store(in: &cancellable)
    }
    
    private func bindError() {
        viewModel.errorRelay.receive(on: DispatchQueue.main).sink {[weak self] error in
            guard let self else { return }
            showError(error)
        }.store(in: &cancellable)
    }
    
}

// MARK: - Movies list collectionView

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieDetails.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: GenresCollectionViewCell.self, for: indexPath)
        cell.setupCell(title: viewModel.movieDetails.genres?[indexPath.row] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
}
