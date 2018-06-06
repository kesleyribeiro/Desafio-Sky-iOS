//
//  MovieCVCell.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 6/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class MovieCVCell: UICollectionViewCell {
 
    // MARK: - Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
    }

}
