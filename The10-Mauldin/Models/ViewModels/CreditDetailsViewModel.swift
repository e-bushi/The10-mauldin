//
//  CreditDetailsViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/15/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

class CreditDetailViewModel {
    var id: Int?
    var cast: [(String, String, String)]?
    var crew: [(String, String)]?
    
    init(credit: Credits) {
        self.id = credit.id
        self.cast = credit.cast
        self.crew = credit.crew
    }
    
    static func retrieveCastProfileImagePath(path: String) -> String? {
        guard let index = path.index(of: "/") else { return nil }
        let endpoint = String(path[index...])
        return endpoint
    }
}
