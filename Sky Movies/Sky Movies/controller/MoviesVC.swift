//
//  MoviesVC.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 6/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    
    lazy var refreshMovies: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(MoviesVC.handleRefresh(_:)), for: UIControlEvents.valueChanged)

        refreshControl.tintColor = UIColor.lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Movies Data...")
        
        return refreshControl
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesCollectionView.addSubview(self.refreshMovies)
    }
    
    
    // MARK: - Funtions
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        print("\nUpdated..")
        // Do some reloading of data and update the collection view's data source
        // Fetch more objects from a web service
        
        // Simply adding an object to the data source
        
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCVCell
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieHeaderView", for: indexPath) as! MovieHeaderView

        headerView.titleCollectionLabel.text = "Uma seleção de filmes imperdíveis:"

        return headerView
    }
    
}


// MARK: - UICollectionViewDelegate

extension MoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("\nHere")
    }
}

