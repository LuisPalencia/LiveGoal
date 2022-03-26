//
//  PlayerTrophiesServerModel.swift
//  FootballApp
//
//  Created by CICE on 25/03/2022.
//

import Foundation

// MARK: - PlayerTrophiesServerModel
struct PlayerTrophiesServerModel: Codable {
    let playerTrophiesServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [PlayerTrophie]?

    enum CodingKeys: String, CodingKey {
        case playerTrophiesServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct PlayerTrophie: Codable {
    let league: String?
    let country: String?
    let season: String?
    let place: String?

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case country = "country"
        case season = "season"
        case place = "place"
    }
}
