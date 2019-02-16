//
//  MovieViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

typealias MovieDetailsResult = (MovieDetailsViewModel) -> ()
typealias CreditDetailsResult = (CreditDetailViewModel) -> ()

class MovieViewModel {
    var id: Int?
    var title: String?
    var posterPath: String?
    var overview: String?
    var releaseDate: String?
    
    private let service = MoyaProvider<TheMovieDBService>(
        plugins: [NetworkLoggerPlugin(verbose: true)])
        
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
    
    func getMovieDetails(completion: @escaping MovieDetailsResult) {
        guard let movieID = self.id else { return }
        service.request(.readMovieDetails(movieID)) { (result) in
            switch result {
            case .success(let response):
                let json = JSON(response.data)
                let id = json["id"].intValue
                let budget = json["budget"].intValue
                let revenue = json["revenue"].intValue
                let runtime = json["runtime"].intValue
                let homepage = json["homepage"].stringValue
                var companies: [String] = []
                var countries: [String] = []
                var genres = [String]()
                json["genres"].array?.forEach({ (genre) in
                    let genreName = genre["name"].stringValue
                    genres.append(genreName)
                })
                
                json["production_companies"].array?.forEach({ (company) in
                    let companyName = company["name"].stringValue
                    companies.append(companyName)
                })
                
                json["production_countries"].array?.forEach({ (country) in
                    let countryName = country["name"].stringValue
                    countries.append(countryName)
                })
                
                let movieDetails = MovieDetails.init(id: id, budget: budget,
                                                     genres: genres,
                                                     productionCompanies: companies,
                                                     productionCountries: countries,
                                                     revenue: revenue, runtime: runtime,
                                                     homepage: homepage)
                
                let viewModel = MovieDetailsViewModel(details: movieDetails)
                
                completion(viewModel)
            case .failure(let error):
                print("There was an issue: \(error.localizedDescription)")
            }
        }
    }
    
    func getCreditDetails(completion: @escaping CreditDetailsResult) {
        guard let movieID = self.id else { return }
        service.request(.readCredits(movieID)) { (result) in
            switch result {
            case .success(let response):
                let json = JSON(response.data)
                let id = json["id"].intValue
                var cast = [(String, String, String)]()
                json["cast"].array?.forEach({ (member) in
                    let character = member["character"].stringValue
                    let name = member["name"].stringValue
                    let profilePath = member["profile_path"].stringValue
//                    let pathWithoutSlash = retr
                    let trifecta = (character, name, profilePath)
                    cast.append(trifecta)
                })
                
                var crew = [(String, String)]()
                json["crew"].array?.forEach({ (member) in
                    let name = member["name"].stringValue
                    let job = member["job"].stringValue
                    let duet = (name, job)
                    crew.append(duet)
                })
                
                let credits = Credits.init(id: id, cast: cast, crew: crew)
                
                let creditDetailsvm = CreditDetailViewModel(credit: credits)
                completion(creditDetailsvm)
                
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
