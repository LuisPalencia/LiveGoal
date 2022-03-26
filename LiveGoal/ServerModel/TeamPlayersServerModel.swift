//
//  TeamPlayersServerModel.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import Foundation

// MARK: - TeamPlayersServerModel
struct TeamPlayersServerModel: Codable {
    let teamPlayersServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [ResponseTeamPlayers]?

    enum CodingKeys: String, CodingKey {
        case teamPlayersServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct ResponseTeamPlayers: Codable {
    let team: Team?
    let players: [Player]?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case players = "players"
    }
}

extension TeamPlayersServerModel {
    
    static var stubbedTeamPlayers: [ResponseTeamPlayers] {
        let results: TeamPlayersServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "TeamPlayers")
        return results?.response ?? []
    }
    
    static var stubbedTeamPlayer: Player {
        return stubbedTeamPlayers[0].players![0]
    }
}
