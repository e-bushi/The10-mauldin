//
//  TheMovieDBService.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/12/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation
import Moya

enum TheMovieDBService {
    fileprivate static let api_key = "511e8d6a464bdf417dcd230a80eeb38b"

    case readUpcomingMovies
    case readNowPlaying
    case readCredits(Int)
    case readMovieDetails(Int)
    
    //MARK: returns Full URL path to fetch images
    static func fullPosterPathUrl(endpoint: String) -> URL {
        let urlString = "https://image.tmdb.org/t/p/w500/\(endpoint)?\(TheMovieDBService.api_key)"
        return URL(string: urlString)!
    }
}

extension TheMovieDBService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
        case .readUpcomingMovies:
            return "/upcoming"
            
        case .readNowPlaying:
            return "/now_playing"
            
        case .readCredits(let movieId):
            return "/\(movieId)/credits"
            
        case .readMovieDetails(let movieID):
            return "/\(movieID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readUpcomingMovies:
            return .get
            
        case .readNowPlaying:
            return .get
            
        case .readCredits:
            return .get
            
        case .readMovieDetails:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .readUpcomingMovies:
            return Data()
            
        case .readNowPlaying:
            return Data()
            
        case .readCredits:
            return Data()
            
        case .readMovieDetails:
            return Data()
        
        }
    }
    
    var task: Task {
        switch self {
        case .readUpcomingMovies, .readNowPlaying, .readCredits, .readMovieDetails:
            return .requestParameters(parameters: ["api_key": TheMovieDBService.api_key], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .readUpcomingMovies, .readNowPlaying, .readCredits(_), .readMovieDetails(_):
            return ["Content-Type": "application/json"]
        }
    }
    
}
