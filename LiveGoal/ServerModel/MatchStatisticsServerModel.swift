//
//  MatchStatisticsServerModel.swift
//  FootballApp
//
//  Created by CICE on 23/03/2022.
//

import Foundation

// MARK: - MatchStatisticsServerModel
struct MatchStatisticsServerModel: Codable {
    let matchStatisticsServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [ResponseMatchStatistics]?

    enum CodingKeys: String, CodingKey {
        case matchStatisticsServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct ResponseMatchStatistics: Codable {
    let team: Team?
    let statistics: [StatisticMatch]?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case statistics = "statistics"
    }
}

// MARK: - Statistic
struct StatisticMatch: Codable {
    let type: String?
    let value: ValueStatistic?
    //let value: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case value = "value"
    }
}

enum ValueStatistic: Codable {
    case integer(Int)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(ValueStatistic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}
