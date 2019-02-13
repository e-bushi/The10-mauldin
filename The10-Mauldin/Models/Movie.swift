//
//  Movie.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/12/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

struct MovieCategory {
    var result: [Movie]
    var page: Int
    var totalResults: Int
    var dates: MinMaxDate
    var totalPages: Int
}

struct Movie {
    var voteCount: Int
    var id: Int
    var title: String
    var posterPath: String
    var overview: String
    var releaseDate: String
}

struct MinMaxDate {
    var maximum: String
    var minimum: String
}
