//
//  GenresCollectionViewCell.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var genreTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(title: String) {
        genreTitleLabel.text = title
    }
}
