//
//  TeamMatchesServerModel.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import Foundation

// MARK: - TeamMatchesServerModel
struct TeamMatchesServerModel: Codable {
    let teamMatchesServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [Match]?

    enum CodingKeys: String, CodingKey {
        case teamMatchesServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct Match: Codable {
    let fixture: Fixture?
    let league: League?
    let teams: Teams?
    let goals: GoalsMatch?
    let score: Score?

    enum CodingKeys: String, CodingKey {
        case fixture = "fixture"
        case league = "league"
        case teams = "teams"
        case goals = "goals"
        case score = "score"
    }
}

// MARK: - Fixture
struct Fixture: Codable {
    let id: Int?
    let referee: String?
    let timezone: String?
    let date: String?
    let timestamp: Int?
    let periods: Periods?
    let venue: Venue?
    let status: Status?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case referee = "referee"
        case timezone = "timezone"
        case date = "date"
        case timestamp = "timestamp"
        case periods = "periods"
        case venue = "venue"
        case status = "status"
    }
}

// MARK: - Periods
struct Periods: Codable {
    let first: Int?
    let second: Int?

    enum CodingKeys: String, CodingKey {
        case first = "first"
        case second = "second"
    }
}

// MARK: - Status
struct Status: Codable {
    let long: String?
    let short: String?
    let elapsed: Int?

    enum CodingKeys: String, CodingKey {
        case long = "long"
        case short = "short"
        case elapsed = "elapsed"
    }
}

// MARK: - Goals
struct GoalsMatch: Codable {
    let home: Int?
    let away: Int?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}

// MARK: - Score
struct Score: Codable {
    let halftime: GoalsMatch?
    let fulltime: GoalsMatch?
    let extratime: Extratime?
    let penalty: Extratime?

    enum CodingKeys: String, CodingKey {
        case halftime = "halftime"
        case fulltime = "fulltime"
        case extratime = "extratime"
        case penalty = "penalty"
    }
}

// MARK: - Extratime
struct Extratime: Codable {
    let home: JSONNull?
    let away: JSONNull?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}

// MARK: - Teams
struct Teams: Codable {
    let home: TeamMatch?
    let away: TeamMatch?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}

// MARK: - Away
struct TeamMatch: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let winner: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
        case winner = "winner"
    }
    
    var logoUrl: URL {
        return URL(string: logo ?? "")!
    }
}

extension TeamMatchesServerModel {
    
    static var stubbedTeamMatches: [Match] {
        let results: TeamMatchesServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "TeamMatches")
        return results?.response ?? []
    }
    
    static var stubbedTeamMatch: Match {
        return stubbedTeamMatches[0]
    }
    
    static var stubbedMatchesRound: [Match] {
        let results: TeamMatchesServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "MatchesRound")
        return results?.response ?? []
    }
}
