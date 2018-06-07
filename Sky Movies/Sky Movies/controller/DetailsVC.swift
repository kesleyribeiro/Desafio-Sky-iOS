//
//  DetailsVC.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 7/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailsVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var actyIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties
    
    var movies: [Movie]?
    var selectedMovie: Movie?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Call the function
        updateUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.movies?.removeAll()
        self.selectedMovie = nil
    }
    
    
    // MARK: - Functions
    
    func updateUI() {
        
        if let movie = selectedMovie {
            
            self.navigationItem.title = movie.title
            
            movieImageView.layer.cornerRadius = 10
            movieImageView.clipsToBounds = true

            durationLabel.text = movie.duration
            yearLabel.text = movie.year
            overviewLabel.text = movie.overview
            
            // Call the function to download image
            downloadImage(image: movie.image)
            
        } else {
            self.navigationItem.title = "Details Movie"
        }
    }
    
    func downloadImage(image: String) {
        
        let imageInCache = AutoPurgingImageCache()
        
        if let image = imageInCache.image(withIdentifier: "imageInCache") {
            self.movieImageView.image = image
            self.actyIndicator.stopAnimating()
        } else {
            
            actyIndicator.startAnimating()
            
            Alamofire.request(image, method: .get).responseImage { resposta in
                
                if let image = resposta.result.value {
                    self.movieImageView.image = image
                    imageInCache.add(image, withIdentifier: "imageInCache")
                } else {
                    self.movieImageView.image = UIImage(named: "placeholder")
                    self.movieImageView.contentMode = .scaleAspectFill
                }
                self.actyIndicator.stopAnimating()
            }
        }
    }

    
}
