//
//  LeagueStanding.swift
//  FootballApp
//
//  Created by CICE on 12/03/2022.
//

import Foundation

// MARK: - LeagueStandingServerModel
struct LeagueStandingServerModel: Codable {
    let leagueStandingServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [ResponseLeagueStanding]?

    enum CodingKeys: String, CodingKey {
        case leagueStandingServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct ResponseLeagueStanding: Codable {
    let league: League?

    enum CodingKeys: String, CodingKey {
        case league = "league"
    }
}

// MARK: - League
struct League: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let standings: [[Standing]]?
    let type: String?
    let round: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case logo = "logo"
        case flag = "flag"
        case season = "season"
        case standings = "standings"
        case type = "type"
        case round = "round"
    }
}

// MARK: - Standing
struct Standing: Codable, Identifiable {
    let rank: Int?
    let team: Team?
    let points: Int?
    let goalsDiff: Int?
    let group: String?
    let form: String?
    let status: String?
    let standingDescription: String?
    let all: All?
    let home: All?
    let away: All?
    let update: String?

    enum CodingKeys: String, CodingKey {
        case rank = "rank"
        case team = "team"
        case points = "points"
        case goalsDiff = "goalsDiff"
        case group = "group"
        case form = "form"
        case status = "status"
        case standingDescription = "description"
        case all = "all"
        case home = "home"
        case away = "away"
        case update = "update"
    }
    
    var id: Int {
        return team?.id ?? 0
    }
}

// MARK: - All
struct All: Codable {
    let played: Int?
    let win: Int?
    let draw: Int?
    let lose: Int?
    let goals: Goals?

    enum CodingKeys: String, CodingKey {
        case played = "played"
        case win = "win"
        case draw = "draw"
        case lose = "lose"
        case goals = "goals"
    }
}

// MARK: - Goals
struct Goals: Codable {
    let goalsFor: Int?
    let against: Int?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against = "against"
    }
}

extension LeagueStandingServerModel {
    
    static var stubbedLeagueStandings: [Standing] {
        let results: LeagueStandingServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "LeagueStanding")
        return results?.response?[0].league?.standings?[0] ?? []
    }
    
    static var stubbedLeagueStanding: Standing {
        return stubbedLeagueStandings[0]
    }
}
