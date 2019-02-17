//
//  HomeViewController.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var MovieCategoryCollection: UICollectionView!
    private var cellID = "MovieCollectionViewCell"
    
    //MARK: Datasource for Upcoming movies
    /* First element in this array will provide the path to an image
     poster for the first cell */
    var upcomingMovies: [MovieViewModel] = [] {
        didSet {
            guard let firstMovie = upcomingMovies.first else {
                print("First Movie was nil")
                return
            }
            firstUpcomingMovie = firstMovie
            MovieCategoryCollection.reloadData()
        }
    }
    //MARK: Initialized by the first element in array above
    var firstUpcomingMovie: MovieViewModel?
    
    //MARK: Datasource for Now Playing movies
    /* First element in this array will provide the path to an image
     poster for the first cell */
    var nowPlayingMovies: [MovieViewModel] = [] {
        didSet {
            guard let firstMovie = nowPlayingMovies.first else {
                print("First Movie was nil")
                return
            }
            firstNowPlayingMovie = firstMovie
            MovieCategoryCollection.reloadData()
        }
    }
    //MARK: Initialized by the first element in array above
    var firstNowPlayingMovie: MovieViewModel?
    
    //MARK: Sets delegate and datasource of collection view
    func setUpDelegatesAndDatasources() {
        MovieCategoryCollection.delegate = self
        MovieCategoryCollection.dataSource = self
        MovieCategoryCollection.register(UINib(nibName: cellID, bundle: nil),
                                         forCellWithReuseIdentifier: cellID)
        
    }
    
    
    
    //MARK: Indexpath used to retrieve cell that was tapped
    var cellPath: IndexPath? {
        didSet {
            performSegue(withIdentifier: "showCategory", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Discover"
        setUpDelegatesAndDatasources()
        //MARK: Get request to retrieve upcoming and now playing movies
        //DATA BINDING: After data is retrieved, it is binded to controller's arrays
        MovieAbstract.retrieveUpcomingMovies { [weak self] (movies) in
            self?.upcomingMovies = movies
        }
        MovieAbstract.retrieveNowPlaying { [weak self] (movies) in
            self?.nowPlayingMovies = movies
        }
    }
    

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as! MovieListingsViewController
        guard let path = cellPath else { return }
        switch path.row {
        case 0:
            controller.upcomingMoviesTransferred = true
            controller.title = "Coming Soon"
            controller.upcomingMovies = self.upcomingMovies
        case 1:
            controller.upcomingMoviesTransferred = false
            controller.title = "Now Playing"
            controller.nowPlayingMovies = self.nowPlayingMovies
        default:
            return
        }
    }

}

extension HomeViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                    for: indexPath) as! MovieCollectionViewCell
        switch indexPath.row {
        case 0:
            //MARK: Retrieve first upcoming movie in datasource
            guard let movie = firstUpcomingMovie else { return cell }
            //MARK: Retrieve the poster path for movie
            guard let posterPath = movie.retrievePosterPath() else { return cell }
            //MARK: Combine poster path with image path to get full URL
            let path = TheMovieDBService.fullPosterPathUrl(endpoint: posterPath)
            cell.movieCategoryLabel.text = "See Movies That Are Coming Soon"
            //MARK: Download and Cashe image
            cell.movieImage.downloadAndCacheImages(url: path)
            return cell
        case 1:
            guard let movie = firstNowPlayingMovie else { return cell }
            guard let posterPath = movie.retrievePosterPath() else { return cell }
            let path = TheMovieDBService.fullPosterPathUrl(endpoint: posterPath)
            cell.movieCategoryLabel.text = "See Movies That Are Now Playing"
            cell.movieImage.downloadAndCacheImages(url: path)
            return cell
            
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        /*MARK: Initialize cellPath property with the indexpath of
        cell the user tapped */
        cellPath = indexPath
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //MARK: Based on size of screen, set appropriate cell size
        return PhoneWidth.movieTypeCellSize()
    }
    
    
}
