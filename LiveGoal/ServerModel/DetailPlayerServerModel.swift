//
//  DetailPlayerServerModel.swift
//  FootballApp
//
//  Created by CICE on 22/03/2022.
//

import Foundation

// MARK: - DetailPlayerServerModel
struct DetailPlayerServerModel: Codable {
    let detailPlayerServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: [PlayerDetail]?

    enum CodingKeys: String, CodingKey {
        case detailPlayerServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct PlayerDetail: Codable {
    let player: Player?
    let statistics: [PlayerStatistic]?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case statistics = "statistics"
    }
}

// MARK: - Player
struct Player: Codable, Identifiable {
    let id: Int?
    let name: String?
    let firstname: String?
    let lastname: String?
    let age: Int?
    let number: Int?
    let position: String?
    let birth: Birth?
    let nationality: String?
    let height: String?
    let weight: String?
    let injured: Bool?
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstname = "firstname"
        case lastname = "lastname"
        case age = "age"
        case number = "number"
        case position = "position"
        case birth = "birth"
        case nationality = "nationality"
        case height = "height"
        case weight = "weight"
        case injured = "injured"
        case photo = "photo"
    }
    
    var photoUrl: URL {
        return URL(string: photo ?? "")!
    }
}

// MARK: - Birth
struct Birth: Codable {
    let date: String?
    let place: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case place = "place"
        case country = "country"
    }
}

// MARK: - Statistic
struct PlayerStatistic: Codable {
    let team: Team?
    let league: League?
    let games: GamesPlayer?
    let substitutes: SubstitutesPlayer?
    let shots: ShotsPlayer?
    let goals: GoalsPlayer?
    let passes: PassesPlayer?
    let tackles: TacklesPlayer?
    let duels: DuelsPlayer?
    let dribbles: DribblesPlayer?
    let fouls: FoulsPlayer?
    let cards: CardsPlayer?
    let penalty: PenaltyPlayer?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case league = "league"
        case games = "games"
        case substitutes = "substitutes"
        case shots = "shots"
        case goals = "goals"
        case passes = "passes"
        case tackles = "tackles"
        case duels = "duels"
        case dribbles = "dribbles"
        case fouls = "fouls"
        case cards = "cards"
        case penalty = "penalty"
    }
}

// MARK: - Cards
struct CardsPlayer: Codable {
    let yellow: Int?
    let yellowred: Int?
    let red: Int?

    enum CodingKeys: String, CodingKey {
        case yellow = "yellow"
        case yellowred = "yellowred"
        case red = "red"
    }
}

// MARK: - Dribbles
struct DribblesPlayer: Codable {
    let attempts: Int?
    let success: Int?
    let past: Int?

    enum CodingKeys: String, CodingKey {
        case attempts = "attempts"
        case success = "success"
        case past = "past"
    }
}

// MARK: - Duels
struct DuelsPlayer: Codable {
    let total: Int?
    let won: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case won = "won"
    }
}

// MARK: - Fouls
struct FoulsPlayer: Codable {
    let drawn: Int?
    let committed: Int?

    enum CodingKeys: String, CodingKey {
        case drawn = "drawn"
        case committed = "committed"
    }
}

// MARK: - Games
struct GamesPlayer: Codable {
    let appearences: Int?
    let lineups: Int?
    let minutes: Int?
    let number: Int?
    let position: String?
    let rating: String?
    let captain: Bool?

    enum CodingKeys: String, CodingKey {
        case appearences = "appearences"
        case lineups = "lineups"
        case minutes = "minutes"
        case number = "number"
        case position = "position"
        case rating = "rating"
        case captain = "captain"
    }
}

// MARK: - Goals
struct GoalsPlayer: Codable {
    let total: Int?
    let conceded: Int?
    let assists: Int?
    let saves: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case conceded = "conceded"
        case assists = "assists"
        case saves = "saves"
    }
}

// MARK: - Passes
struct PassesPlayer: Codable {
    let total: Int?
    let key: Int?
    let accuracy: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case key = "key"
        case accuracy = "accuracy"
    }
}

// MARK: - Penalty
struct PenaltyPlayer: Codable {
    let won: Int?
    let commited: Int?
    let scored: Int?
    let missed: Int?
    let saved: Int?

    enum CodingKeys: String, CodingKey {
        case won = "won"
        case commited = "commited"
        case scored = "scored"
        case missed = "missed"
        case saved = "saved"
    }
}

// MARK: - Shots
struct ShotsPlayer: Codable {
    let total: Int?
    let on: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case on = "on"
    }
}

// MARK: - Substitutes
struct SubstitutesPlayer: Codable {
    let substitutesIn: Int?
    let out: Int?
    let bench: Int?

    enum CodingKeys: String, CodingKey {
        case substitutesIn = "in"
        case out = "out"
        case bench = "bench"
    }
}

// MARK: - Tackles
struct TacklesPlayer: Codable {
    let total: Int?
    let blocks: Int?
    let interceptions: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case blocks = "blocks"
        case interceptions = "interceptions"
    }
}

extension DetailPlayerServerModel {
    
    static var stubbedPlayer: PlayerDetail {
        let results: DetailPlayerServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "DetailPlayer")
        return (results?.response?[0])!
    }
    
}
