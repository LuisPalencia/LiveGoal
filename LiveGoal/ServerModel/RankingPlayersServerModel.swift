//
//  RankingPlayersServerModel.swift
//  LiveGoal
//
//  Created by CICE on 26/03/2022.
//

import Foundation

// MARK: - RankingPlayersServerModel
struct RankingPlayersServerModel: Codable {
    let rankingPlayersServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [RankingPlayer]?

    enum CodingKeys: String, CodingKey {
        case rankingPlayersServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct RankingPlayer: Codable {
    let player: Player?
    let statistics: [PlayerStatistic]?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case statistics = "statistics"
    }
}

extension RankingPlayersServerModel {
    
    static var stubbedTopPlayers: [RankingPlayer] {
        let results: RankingPlayersServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "TopPlayerScorers")
        return (results?.response)!
    }
    
    static var stubbedTopPlayer: RankingPlayer {
        return stubbedTopPlayers[0]
    }
}
