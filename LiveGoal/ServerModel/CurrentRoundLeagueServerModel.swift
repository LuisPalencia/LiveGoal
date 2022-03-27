//
//  CurrentRoundLeagueServerModel.swift
//  LiveGoal
//
//  Created by CICE on 27/03/2022.
//


import Foundation

// MARK: - CurrentRoundLeagueServerModel
struct CurrentRoundLeagueServerModel: Codable {
    let currentRoundLeagueServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [String]?

    enum CodingKeys: String, CodingKey {
        case currentRoundLeagueServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}
