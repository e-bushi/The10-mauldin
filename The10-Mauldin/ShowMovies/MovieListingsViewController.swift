//
//  MovieListingsViewController.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import UIKit

class MovieListingsViewController: UIViewController {
    
    @IBOutlet weak var movieListCollection: UICollectionView!
    let cellID = "MovieListCollectionViewCell"
    
    @IBOutlet weak var movieCastCollection: UICollectionView!
    let castCellID = "MovieCastCollectionViewCell"
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var productionCompaniesLabel: UILabel!
    @IBOutlet weak var countryNamesLabel: UILabel!
    @IBOutlet weak var dateOfReleaseLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var filmDurationLabel: UILabel!
    @IBOutlet weak var revenueAmountLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    
    enum MovieSections: Int {
        case zero = 0, one, two, three, four, five, six,
        seven, eight, nine
    }
    /* MARK: Flag that determines if we'll use upcoming or nowplaying
    datasources */
    var upcomingMoviesTransferred: Bool = true
    
    /*MARK: When movie is tapped, its indexpath is set and stored;
    after being set we know correct positions of the data we need,
    to display the right data to user */
    var cellPath: IndexPath = IndexPath(row: 0, section: 0) {
        /*Attn: we give cellPath initial value, so that elements
        can be properly set when view loads*/
        didSet {
            switch upcomingMoviesTransferred {
            case true:
                setElementValues(section: cellPath.section, which: upcomingMovies)
            case false:
                setElementValues(section: cellPath.section, which: nowPlayingMovies)
            }
        }
    }
    
    //MARK: Set Element Data
    func setElementValues(section: Int, which movies: [MovieViewModel]) {
        guard let movieID = movies[section].id else { return }
        let detail = details.first { $0.id == movieID }
        guard let movieDetail = detail else { return }
        let credDetail = credits.first { $0.id == movieID }
        guard let creditDetails = credDetail else { return }
        self.movieTitleLabel.text = movies[section].title
        var director: String = ""
        let nameJobTuple = creditDetails.crew?.first { $0.1 == "Director" }
        guard let nameJob = nameJobTuple else { return }
        director = nameJob.0
        self.directorNameLabel.text = director
        self.overviewTextView.text = movies[section].overview
        var companies: String = ""
        movieDetail.productionCompanies?.forEach({ (names) in
            
            companies += "\(names) - "
        })
        self.productionCompaniesLabel.text = companies
        
        var countries: String = ""
        movieDetail.productionCountries?.forEach({ (country) in
            countries += "\(country) - "
        })
        
        var genres: String = ""
        movieDetail.genres?.forEach({ (genre) in
            genres += "\(genre) - "
        })
        
        self.countryNamesLabel.text = countries
        self.dateOfReleaseLabel.text = movies[section].releaseDate
        self.genreNameLabel.text = genres
        self.filmDurationLabel.text = "\(movieDetail.runtime!) Mins"
        self.revenueAmountLabel.text = Int.Currency(value: movieDetail.revenue!)
        self.homepageLabel.text = movieDetail.homepage
    }
    
    //MMARK: Datasources for movie list collection
    var upcomingMovies: [MovieViewModel] = []
    var nowPlayingMovies: [MovieViewModel] = []
    
    //MARK: Object that provides movie details
    var details: [MovieDetailsViewModel] = [] {
        didSet {
            
        }
    }
    
    //MARK: Datasource for movie cast and crew collection
    /*Since this is the last piece of data retrieved we must
    reload both collection views, so they can have access to the
    latest data */
    var credits: [CreditDetailViewModel] = [] {
        didSet {
            movieListCollection.reloadData()
            movieCastCollection.reloadData()
        }
    }
    
    //MARK: register cells and set delegates and datasources
    func setUpDelegatesDatasourcesAndCell() {
        movieListCollection.delegate = self
        movieListCollection.dataSource = self
        
        movieListCollection.register(UINib(nibName: cellID, bundle: nil),
                                     forCellWithReuseIdentifier: cellID)
        
        movieCastCollection.delegate = self
        movieCastCollection.dataSource = self
        movieCastCollection.register(UINib(nibName: castCellID, bundle: nil),
                                     forCellWithReuseIdentifier: castCellID)
    }
    
    //MARK: Based on flag we fetch upcoming or now playing credit details
    func getCreditData() {
        switch upcomingMoviesTransferred {
        case true:
            upcomingMovies.forEach { (movie) in
                movie.getCreditDetails(completion: { (credits) in
                    self.credits.append(credits)
                })
            }

        case false:
            nowPlayingMovies.forEach { (movie) in
                movie.getCreditDetails(completion: { (credits) in
                    self.credits.append(credits)
                })
            }
        }
    }
    
    //MARK: Based on flag we fetch upcoming or now playing movie details
    func getMovieDetails() {
        switch upcomingMoviesTransferred {
        case true:
            upcomingMovies.forEach { (movie) in
                movie.getMovieDetails(completion: { (movieDetails) in
                    self.details.append(movieDetails)
                })
            }
            
        case false:
            nowPlayingMovies.forEach { (movie) in
                movie.getMovieDetails(completion: { (movieDetails) in
                    self.details.append(movieDetails)
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpDelegatesDatasourcesAndCell()
        getMovieDetails()
        getCreditData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MovieListingsViewController: UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case movieListCollection:
            return MovieSections.nine.rawValue + 1
            
        case movieCastCollection:
            return 1
            
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case movieListCollection:
            return 1
        case movieCastCollection:
            return 7
        default:
            return 0
        }
    }
    
    /*MARK: Based on section, we retrieve path contents of a specific
    movie, and merge it with the image path to create full URL */
    func retrieveFullPosterPathForMovies(section: Int) -> URL? {
        var posterPath: String
        switch upcomingMoviesTransferred {
        case true:
            guard let pPath = upcomingMovies[section].posterPath else {
                return nil
            }
            posterPath = pPath
            
        case false:
            guard let pPath = nowPlayingMovies[section].posterPath else {
                return nil
            }
            posterPath = pPath
        }
        
        return TheMovieDBService.fullPosterPathUrl(endpoint: posterPath)
    }
    
    /*MARK: Abstract process of capturing and setting data for cells */
    func intializeCellData(_ cellPath: inout IndexPath,
                           movies: [MovieViewModel],
                           cell: MovieCastCollectionViewCell) -> MovieCastCollectionViewCell {
        let movieId = movies[cellPath.section].id
        let creditVm = credits.first { $0.id == movieId }
        guard let trifecta = creditVm?.cast?[cellPath.row] else { return cell }
        guard let path = CreditDetailViewModel.retrieveCastProfileImagePath(path: trifecta.2)
            else {
                return cell
        }
        let fullUrl = TheMovieDBService.fullPosterPathUrl(endpoint: path)
        cell.actorImage.downloadAndCacheImages(url: fullUrl)
        cellPath.row += 1
        if cellPath.row > 6 {
            cellPath.row = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell: MovieListCollectionViewCell
        let castCell: MovieCastCollectionViewCell
        
        switch collectionView {
        case movieListCollection:
            movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                        for: indexPath) as! MovieListCollectionViewCell
            
            guard let fullPath = retrieveFullPosterPathForMovies(section: indexPath.section) else
            { return movieCell }
            movieCell.movieImageView.downloadAndCacheImages(url: fullPath)
            return movieCell
            
        case movieCastCollection:
            castCell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellID,
                                        for: indexPath) as! MovieCastCollectionViewCell
            /*MARK: Check if both datasources have data*/
            if credits.count > 0 && details.count > 0 {
                switch upcomingMoviesTransferred{
                case true:
                    setElementValues(section: cellPath.section, which: upcomingMovies)
                    return intializeCellData(&cellPath,
                                             movies: upcomingMovies,
                                             cell: castCell)
                    
                case false:
                    setElementValues(section: cellPath.section, which: nowPlayingMovies)
                    return intializeCellData(&cellPath,
                                             movies: nowPlayingMovies,
                                             cell: castCell)
                }
            } else {
                return castCell
            }
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case movieListCollection:
            /* MARK: Once a new image in the list is tapped,
            pass cellpath a new value and reload the cast data */
            cellPath = indexPath
            movieCastCollection.reloadData()
            return
            
        case movieCastCollection:
            return
        default:
            return
        }
    
    }
    
    
    //MARK: Animate when movie in list is tapped
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieListCollectionViewCell {
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 3.0, options: [.curveEaseInOut], animations: {
                cell.transform = .init(scaleX: 0.7, y: 0.7)
            }, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieListCollectionViewCell {
            UIView.animate(withDuration: 0.5) {
                cell.transform = .identity
                cell.isSelected = false
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case movieListCollection:
            return PhoneWidth.movieListCellSize()
        case movieCastCollection:
            return CGSize(width: 100, height: 100)
            
        default:
            return CGSize.zero
        }
    }
    
    
}



