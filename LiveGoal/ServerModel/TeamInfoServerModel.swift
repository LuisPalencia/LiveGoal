//
//  TeamInfoServerModel.swift
//  FootballApp
//
//  Created by CICE on 14/03/2022.
//

import Foundation

// MARK: - TeamInfoServerModel
struct TeamInfoServerModel: Codable {
    let teamInfoServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [ResponseTeamInfo]?

    enum CodingKeys: String, CodingKey {
        case teamInfoServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct ResponseTeamInfo: Codable {
    let team: Team?
    let venue: Venue?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case venue = "venue"
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let country: String?
    let founded: Int?
    let national: Bool?
    let logo: String?
    let colors: Colors?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case code = "code"
        case country = "country"
        case founded = "founded"
        case national = "national"
        case logo = "logo"
        case colors = "colors"
    }
    
    var logoUrl: URL {
        return URL(string: logo ?? "")!
    }
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int?
    let name: String?
    let address: String?
    let city: String?
    let capacity: Int?
    let surface: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case city = "city"
        case capacity = "capacity"
        case surface = "surface"
        case image = "image"
    }
    
    var imageUrl: URL {
        return URL(string: image ?? "")!
    }
}

extension TeamInfoServerModel {
    
    static var stubbedTeamInfo: ResponseTeamInfo {
        let results: TeamInfoServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "TeamInfo")
        return (results?.response?[0])!
    }
}
