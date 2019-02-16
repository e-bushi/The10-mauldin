//
//  MovieAbstract.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON


typealias UpcomingMovieResults = ([MovieViewModel]) -> ()
typealias nowPlayingMovieResults = ([MovieViewModel]) -> ()

class MovieAbstract {
        
    private init() {}
    
    private static let service = MoyaProvider<TheMovieDBService>(
        plugins: [NetworkLoggerPlugin(verbose: true)])
    
    //MARK: Get request to retrieve Upcoming Movies
    static func retrieveUpcomingMovies(completion: @escaping UpcomingMovieResults) {
        var upcomingMovies: [MovieViewModel] = []
        service.request(.readUpcomingMovies) { (result) in
            switch result {
            case .success(let response):
                var json = JSON(response.data)
                json["results"].array?.forEach({ (movie) in
                    let movie = Movie(id: movie["id"].intValue,
                                      title: movie["title"].stringValue,
                                      posterPath: movie["poster_path"].stringValue,
                                      overview: movie["overview"].stringValue,
                                      releaseDate: movie["release_date"].stringValue)
                    
                    let movieVM = MovieViewModel(movie: movie)
                    if upcomingMovies.count == 10 {
                        return
                    } else {
                        upcomingMovies.append(movieVM)
                    }
                })
                
                completion(upcomingMovies)
                
            case .failure(let error):
                print("Something went wrong: \(String(describing: error.errorDescription))")
            }
        }
    }
    
    //MARK: Get Request to retrieve movies that are now playing
    static func retrieveNowPlaying(completion: @escaping nowPlayingMovieResults) {
        var nowPlayingMovies: [MovieViewModel] = []
        service.request(.readNowPlaying) { (result) in
            switch result {
            case .success(let response):
                var json = JSON(response.data)
                json["results"].array?.forEach({ (movie) in
                    let movie = Movie(id: movie["id"].intValue,
                                      title: movie["title"].stringValue,
                                      posterPath: movie["poster_path"].stringValue,
                                      overview: movie["overview"].stringValue,
                                      releaseDate: movie["release_date"].stringValue)
                    
                    let movieVM = MovieViewModel(movie: movie)
                    if nowPlayingMovies.count == 10 {
                        return
                    } else {
                        nowPlayingMovies.append(movieVM)
                    }
                })
                
                completion(nowPlayingMovies)
                
            case .failure(let error):
                print("Something went wrong: \(String(describing: error.errorDescription))")
            }
        }
    }
    
}
