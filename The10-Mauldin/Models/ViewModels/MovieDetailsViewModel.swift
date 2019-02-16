//
//  MovieDetailsViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    var id: Int?
    var budget: Int?
    var genres: [String]?
    var productionCompanies: [String]?
    var productionCountries: [String]?
    var revenue: Int?
    var runtime: Int?
    var homepage: String?
    
    init(details: MovieDetails) {
        self.id = details.id
        self.budget = details.budget
        self.genres = details.genres
        self.productionCompanies = details.productionCompanies
        self.productionCountries = details.productionCountries
        self.revenue = details.revenue
        self.runtime = details.runtime
        self.homepage = details.homepage
    }
}
