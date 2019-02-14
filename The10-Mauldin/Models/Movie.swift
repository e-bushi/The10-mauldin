//
//  Movie.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/12/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

struct MovieCategory {
    var results: [Movie]
}

struct Movie {
    var id: Int
    var title: String
    var posterPath: String
    var overview: String
    var releaseDate: String
}

