//
//  MovieDetails.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

struct MovieDetails {
    var budget: Int
    var genres: [Genre]
    var productionCompanies: [Production]
    var revenue: Int
    var runtime: Int
}

extension MovieDetails: Decodable {
    enum Keys: String, CodingKey {
        case productionCompanies = "production_companies"
    }
}

struct Genre: Decodable {
    var id: Int
    var name: String
}

struct Production: Decodable {
    var id: Int
    var name: String
}
