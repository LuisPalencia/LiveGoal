//
//  PlayerTransfersServerModel.swift
//  LiveGoal
//
//  Created by CICE on 29/03/2022.
//

import Foundation

// MARK: - PlayerTransfersServerModel
struct PlayerTransfersServerModel: Codable {
    let playerTransfersServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [PlayerTransfers]?

    enum CodingKeys: String, CodingKey {
        case playerTransfersServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct PlayerTransfers: Codable {
    let player: Player?
    let update: String?
    let transfers: [Transfer]?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case update = "update"
        case transfers = "transfers"
    }
}

// MARK: - Transfer
struct Transfer: Codable {
    let date: String?
    let type: String?
    let teams: TeamsInOutTransfer?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case type = "type"
        case teams = "teams"
    }
}

// MARK: - Teams
struct TeamsInOutTransfer: Codable {
    let teamIn: TeamTransfer?
    let teamOut: TeamTransfer?

    enum CodingKeys: String, CodingKey {
        case teamIn = "in"
        case teamOut = "out"
    }
}

// MARK: - In
struct TeamTransfer: Codable {
    let id: Int?
    let name: String?
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
    
    var logoUrl: URL {
        return URL(string: logo ?? "")!
    }
}

extension PlayerTransfersServerModel {
    
    static var stubbedPlayerTransfersList: [Transfer] {
        let results: PlayerTransfersServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "PlayerTransfers")
        return (results?.response![0].transfers)!
    }
    
    static var stubbedPlayerTransfer: Transfer {
        return stubbedPlayerTransfersList[0]
    }
}
