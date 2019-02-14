//
//  MovieDetailsViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    var budget: Int?
    var genres: [Genre]?
    var productionCompanies: [Production]?
    var revenue: Int?
    var runtime: Int?
    
    init(details: MovieDetails) {
        self.budget = details.budget
        self.genres = details.genres
        self.productionCompanies = details.productionCompanies
        self.revenue = details.revenue
        self.runtime = details.runtime
    }
}
