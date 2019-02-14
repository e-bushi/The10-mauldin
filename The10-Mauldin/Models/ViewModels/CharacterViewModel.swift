//
//  CharacterViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

class CharacterViewModel {
    var castId: Int?
    var character: String?
    var creditId: String?
    var gender: Int?
    var id: Int?
    var name: String?
    var order: Int?
    var profilePath: String?
    
    init(character: CharacterEntity) {
        self.castId = character.castId
        self.character = character.character
        self.creditId = character.creditId
        self.gender = character.gender
        self.id = character.id
        self.name = character.name
        self.order = character.order
        self.profilePath = character.profilePath
    }
    
    /*TO DO: Create methods to fetch images*/
}
