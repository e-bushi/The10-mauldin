//
//  CrewmanViewModel.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

class CrewmanViewModel {
    var creditId: String?
    var department: String?
    var gender: Int?
    var id: Int?
    var job: String?
    var name: String?
    var profilePath: String?
    
    init(crewman: CrewEntity) {
        self.creditId = crewman.creditId
        self.department = crewman.department
        self.gender = crewman.gender
        self.id = crewman.id
        self.job = crewman.job
        self.name = crewman.name
        self.profilePath = crewman.profilePath
    }
}

