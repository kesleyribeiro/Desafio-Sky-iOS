//
//  MovieCVCell.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 6/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieCVCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var actyIndicator: UIActivityIndicatorView!
    
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        self.actyIndicator.startAnimating()
    }
    
    
    // MARK: - Function

    func configureCell(movie: Movie) {
        
        titleMovieLabel.text = movie.title
        
        let imageInCache = AutoPurgingImageCache()
        
        if let image = imageInCache.image(withIdentifier: "imageInCache") {
            self.movieImageView.image = image
            self.actyIndicator.stopAnimating()

        } else {
            
            actyIndicator.startAnimating()
            
            Alamofire.request(movie.image, method: .get).responseImage { resposta in
                
                if let image = resposta.result.value {
                    self.movieImageView.image = image
                    imageInCache.add(image, withIdentifier: "imageInCache")
                } else {
                    self.movieImageView.image = UIImage(named: "placeholder")
                }
                self.actyIndicator.stopAnimating()
            }
        }
    }
    
}
