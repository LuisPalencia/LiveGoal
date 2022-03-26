//
//  MatchEventsServerModel.swift
//  FootballApp
//
//  Created by CICE on 23/03/2022.
//

import Foundation

// MARK: - MatchEventsServerModel
struct MatchEventsServerModel: Codable {
    let matchEventsServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [MatchEventModel]?

    enum CodingKeys: String, CodingKey {
        case matchEventsServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct MatchEventModel: Codable, Identifiable {
    let id = UUID()
    let time: Time?
    let team: Team?
    let player: Player?
    let assist: AssistEvent?
    let type: String?
    let detail: String?
    let comments: String?

    enum CodingKeys: String, CodingKey {
        case time = "time"
        case team = "team"
        case player = "player"
        case assist = "assist"
        case type = "type"
        case detail = "detail"
        case comments = "comments"
    }
    
    var minute: Int {
        return (time?.elapsed ?? 0) + (time?.extra ?? 0)
    }
}

// MARK: - Assist
struct AssistEvent: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - Time
struct Time: Codable {
    let elapsed: Int?
    let extra: Int?

    enum CodingKeys: String, CodingKey {
        case elapsed = "elapsed"
        case extra = "extra"
    }
}

extension MatchEventsServerModel {
    
    static var stubbedMatchEvents: [MatchEventModel] {
        let results: MatchEventsServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "MatchEvents")
        return (results?.response)!
    }
    
    static var stubbedMatchEvent: MatchEventModel {
        return stubbedMatchEvents[2]
    }
}
