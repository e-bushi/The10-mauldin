//
//  MovieViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation
import Moya

class MovieViewModel {
    var id: Int?
    var title: String?
    var posterPath: String?
    var overview: String?
    var releaseDate: String?
    
    private let service = MoyaProvider<TheMovieDBService>(
        plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var Details: MovieDetailsViewModel?
    var cast: [CharacterViewModel] = []
    var crew: [CrewmanViewModel] = []
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
    }
    
    /*TO DO: Once properties have been intialized, create methods
      fetching credits, and specific movie details
    */
    
    func getMovieDetails(completion: @escaping () -> ()) {
        guard let movieID = self.id else { return }
        service.request(.readCredits(movieID)) { (result) in
            switch result {
            case .success(let response):
                guard let movieDetails = try?
                    JSONDecoder().decode(MovieDetails.self, from: response.data) else
                {
                    print("Details were't decoded correctly")
                    return
                }
                
                self.Details = MovieDetailsViewModel(details: movieDetails)
                
            case .failure(let error):
                print("There was an issue: \(error.localizedDescription)")
            }
        }
    }
    
    func getCreditDetails(completion: @escaping () -> ()) {
        guard let movieID = self.id else { return }
        service.request(.readCredits(movieID)) { (result) in
            switch result {
            case .success(let response):
                guard let creditDetails = try?
                    JSONDecoder().decode(Credits.self, from: response.data) else
                {
                    print("Credits were't decoded correctly")
                    return
                }
                
                self.cast = creditDetails.cast.map { CharacterViewModel(character: $0) }
                self.crew = creditDetails.crew.map { CrewmanViewModel(crewman: $0) }
                
            case .failure(let error):
                print("There was an issue: \(error.localizedDescription)")
            }
        }
    }
    
    func retrievePosterPath() -> String? {
        guard let posterUrl = self.posterPath else { return nil }
        guard let index = posterUrl.index(of: "/") else { return nil }
        let endpoint = String(posterUrl[index...])
        return endpoint
    }
    
    
}
