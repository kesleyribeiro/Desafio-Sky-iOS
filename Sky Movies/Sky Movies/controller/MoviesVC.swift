//
//  MoviesVC.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 6/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Alamofire

class MoviesVC: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    
    // MARK: - Properties
    
    var movies = [Movie]()
    var numberOfMovies = Int()
    var selectedMovie: Movie?
    var detailsVC: DetailsVC?
    var showAlerts = Alerts()
    var timer = Timer()
    
    struct Storyboard {
        static let showDetails = "showDetails"
    }
    
    lazy var refreshMovies: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(MoviesVC.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Loading movies data...")
        
        return refreshControl
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.moviesCollectionView.addSubview(self.refreshMovies)
        
        getMovies()
    }
    
    
    // MARK: - Funtions
    
    @objc func getMovies() {
        
        Alamofire.request(URL_API_SKY, method: .get).responseJSON
            { response in                                
                
                if response.result.isSuccess {
                    let result = response.result
                    
                    if let dict = result.value as? [Dictionary<String, AnyObject>] {
                        
                        // Update the number of movies
                        self.numberOfMovies = dict.count
                        
                        self.moviesCollectionView.isHidden = false
                        self.noResultsLabel.isHidden = true
                        
                        for obj in dict {
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        self.moviesCollectionView.reloadData()
                    }
                } else {
                    
                    self.showAlerts.exibirAlertaPersonalizado("Erro ao tentar obter os dados, tentar novamente mais tarde!", tipoAlerta: 2)
                                        
                    self.moviesCollectionView.isHidden = true
                    self.noResultsLabel.isHidden = false
                    
                    // Call the function to try get data
                    self.tryAgainGetData()
                }
        }
    }

    func tryAgainGetData() {
        
        // After 15 seconds, execute the function to try to get the data
        self.timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.getMovies), userInfo: nil, repeats: false)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        // Call the function again
        getMovies()
        
        // Refresh collection view
        self.moviesCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
}

// MARK: - UICollectionViewDataSource

extension MoviesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCVCell {
            
            let movie = movies[indexPath.row]
            
            cell.configureCell(movie: movie)
            return cell
            
        } else {
            return MovieCVCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieHeaderView", for: indexPath) as! MovieHeaderView
        
        headerView.titleCollectionLabel.text = "Uma seleção de filmes imperdíveis:"
        
        return headerView
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Storyboard.showDetails {
            let details = segue.destination as! DetailsVC
            details.selectedMovie = selectedMovie
        }
    }
    
}


// MARK: - UICollectionViewDelegate

extension MoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedMovie = movies[indexPath.row]        
        self.detailsVC?.selectedMovie = selectedMovie
        
        // Call the DetailsVC - Detail UI
        performSegue(withIdentifier: Storyboard.showDetails, sender: selectedMovie)
    }
}

