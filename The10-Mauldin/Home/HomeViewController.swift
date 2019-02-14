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
    
    var firstUpcomingMovie: MovieViewModel?
    
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
    
    var firstNowPlayingMovie: MovieViewModel?
    
    func setUpDelegatesAndDatasources() {
        MovieCategoryCollection.delegate = self
        MovieCategoryCollection.dataSource = self
        MovieCategoryCollection.register(UINib(nibName: cellID, bundle: nil),
                                         forCellWithReuseIdentifier: cellID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Discover"
        setUpDelegatesAndDatasources()
        //MARK: DATA BINDING
        MovieAbstract.retrieveUpcomingMovies { [weak self] (movies) in
            self?.upcomingMovies = movies
        }

        MovieAbstract.retrieveNowPlaying { [weak self] (movies) in
            self?.nowPlayingMovies = movies
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func fullPosterPathUrl(endpoint: String) -> URL {
        let urlString = "https://image.tmdb.org/t/p/w500/\(endpoint)?api_key=511e8d6a464bdf417dcd230a80eeb38b"
        return URL(string: urlString)!
    }
    
    func downloadAndCacheImages(image: ImageView, url: URL) {
        let processor = DownsamplingImageProcessor(size: image.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 20)
        var newImage = image
        newImage.kf.indicatorType = .activity
        newImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }

}

extension HomeViewController: UICollectionViewDelegate,
UICollectionViewDataSource {
    
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
            guard let movie = firstUpcomingMovie else { return cell }
            guard let posterPath = movie.retrievePosterPath() else { return cell }
            let path = fullPosterPathUrl(endpoint: posterPath)
            cell.movieCategoryLabel.text = "See Movies That Are Coming Soon"
            
            cell.movieImage.kf.setImage(with: path, options: [.transition(.fade(0.3))])
            return cell
        case 1:
            guard let movie = firstNowPlayingMovie else { return cell }
            guard let posterPath = movie.retrievePosterPath() else { return cell }
            let path = fullPosterPathUrl(endpoint: posterPath)
            cell.movieCategoryLabel.text = "See Movies That Are Now Playing"
            downloadAndCacheImages(image: cell.movieImage, url: path)
            return cell
            
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showCategory", sender: self)
    }
    
    
    
}
