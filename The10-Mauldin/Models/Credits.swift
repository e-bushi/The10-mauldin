//
//  Credits.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/12/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

struct Credits: Codable {
    var id: Int
    var cast: [CharacterEntity]
    var crew: [CrewEntity]
}

struct CharacterEntity: Codable {
    var castId: Int
    var character: String
    var creditId: String
    var gender: Int
    var id: Int
    var name: String
    var order: Int
    var profilePath: String
}

struct CrewEntity: Codable {
    var creditId: String
    var department: String
    var gender: Int
    var id: Int
    var job: String
    var name: String
    var profilePath: String
}
