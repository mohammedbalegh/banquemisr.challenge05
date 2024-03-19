//
//  MoviesCollectionViewCell.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 15/03/2024.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var posterImage: LoadingImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addShadow()
    }
    
    func setupCell(movie: Movie) {
        posterImage.loadImage(from: movie.posterPath)
        titleLabel.text = movie.title
        releaseDateLabel.text = "Released: " + (movie.releaseDate ?? "")
    }

}
