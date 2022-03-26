//
//  SeasonRoundsServerModel.swift
//  FootballApp
//
//  Created by CICE on 22/03/2022.
//

import Foundation

struct SeasonRoundsServerModel: Codable {
    let seasonRoundsServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [String]?

    enum CodingKeys: String, CodingKey {
        case seasonRoundsServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}
