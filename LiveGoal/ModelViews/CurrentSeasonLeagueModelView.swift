//
//  CurrentSeasonLeagueModelView.swift
//  FootballApp
//
//  Created by CICE on 12/03/2022.
//

import Foundation

struct CurrentSeasonLeagueModelView: Identifiable{
    // League params
    let id: Int?
    let name: String?
    let type: String?
    let logo: String?
    
    // Season params
    let year: Int?
    let start: String?
    let end: String?
    
    // Country params
    let nameCountry: String?
    let codeCountry: String?
    let flag: String?
    
    // Standing
    
    
    init(id: Int?, name: String?, type: String?, logo: String?, year: Int?, start: String?, end: String?, nameCountry: String?, codeCountry: String?, flag: String?, standing: [Standing]?) {
        self.id = id
        self.name = name
        self.type = type
        self.logo = logo
        self.year = year
        self.start = start
        self.end = end
        self.nameCountry = nameCountry
        self.codeCountry = codeCountry
        self.flag = flag
        //self.standing = standing
    }
    
    init() {
        id = 0
        name = ""
        type = ""
        logo = ""
        year = 0
        start = ""
        end = ""
        nameCountry = ""
        codeCountry = ""
        flag = ""
        //standing = []
    }
}
