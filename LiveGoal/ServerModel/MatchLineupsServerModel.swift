//
//  MatchLineupsServerModel.swift
//  FootballApp
//
//  Created by CICE on 23/03/2022.
//

import Foundation
import SwiftUI

// MARK: - MatchLineupsServerModel
struct MatchLineupsServerModel: Codable {
    let matchLineupsServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [MatchLineupTeam]?

    enum CodingKeys: String, CodingKey {
        case matchLineupsServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct MatchLineupTeam: Codable {
    let team: Team?
    let coach: Coach?
    let formation: String?
    let startXI: [PlayerMatch]?
    let substitutes: [PlayerMatch]?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case coach = "coach"
        case formation = "formation"
        case startXI = "startXI"
        case substitutes = "substitutes"
    }
    
    var goalkeepersStart: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "G" }
    }
    
    var defendersStart: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "D" }
    }
    
    var midfieldersStart: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "M" }
    }
    
    var attackersStart: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "F" }
    }
    
    var goalkeepersSubtitutes: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "G" }
    }
    
    var defendersSubtitutes: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "D" }
    }
    
    var midfieldersSubtitutes: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "M" }
    }
    
    var attackersSubtitutes: [PlayerMatch]? {
        startXI?.filter{ $0.player?.pos == "F" }
    }
}

// MARK: - Coach
struct Coach: Codable {
    let id: Int?
    let name: String?
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "photo"
    }
}

// MARK: - StartXI
struct PlayerMatch: Codable {
    let player: PlayerMatchModel?

    enum CodingKeys: String, CodingKey {
        case player = "player"
    }
}

// MARK: - StartXIPlayer
struct PlayerMatchModel: Codable {
    let id: Int?
    let name: String?
    let number: Int?
    let pos: String?
    let grid: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case number = "number"
        case pos = "pos"
        case grid = "grid"
    }
}

// MARK: - Colors
struct Colors: Codable {
    let player: ColorTeam?
    let goalkeeper: ColorTeam?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case goalkeeper = "goalkeeper"
    }
}

// MARK: - ColorTeam
struct ColorTeam: Codable {
    let primary: String?
    let number: String?
    let border: String?

    enum CodingKeys: String, CodingKey {
        case primary = "primary"
        case number = "number"
        case border = "border"
    }
    
}

extension MatchLineupsServerModel {
    
    static var stubbedMatchLineupTeams: [MatchLineupTeam] {
        let results: MatchLineupsServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "MatchLineups")
        return (results?.response)!
    }
    
    static var stubbedMatchLineupHomeTeam: MatchLineupTeam {
        return stubbedMatchLineupTeams[0]
    }
    
    static var stubbedMatchLineupAwayTeam: MatchLineupTeam {
        return stubbedMatchLineupTeams[1]
    }
    
    static var stubbedMatchLineupHomeTeamPlayer: PlayerMatch {
        return stubbedMatchLineupHomeTeam.startXI![0]
    }
    
    static var stubbedMatchLineupAwayTeamPlayer: PlayerMatch {
        return stubbedMatchLineupAwayTeam.startXI![0]
    }
}
