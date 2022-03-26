//
//  Utils.swift
//  FootballApp
//
//  Created by CICE on 12/03/2022.
//

import Foundation
import SwiftUI

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case options = "OPTIONS"
}

enum TargetEnvironment: Int {
    case DEV = 0
    case PRE = 1
    case PRO = 3
}

struct RequestDTO {
    var params: [String: AnyObject]?
    var arrayParams: [[String: AnyObject]]?
    var method: HTTPMethods
    var endpoint: String
    var urlContext: URLEnpoint.BaseUrlContext
    var header: [String: String]?
    
    init(params: [String: AnyObject]?, method: HTTPMethods, endpoint: String, urlContext: URLEnpoint.BaseUrlContext, header: [String: String]?){
        self.params = params
        self.method = method
        self.endpoint = endpoint
        self.urlContext = urlContext
        self.header = header
    }
    
    init(arrayParams: [[String: AnyObject]]?, method: HTTPMethods, endpoint: String, urlContext: URLEnpoint.BaseUrlContext){
        self.arrayParams = arrayParams
        self.method = method
        self.endpoint = endpoint
        self.urlContext = urlContext
    }
}

struct URLEnpoint {
    
    #if DEV
    static let environmentDefault: TargetEnvironment = TargetEnvironment.DEV
    #elseif PRE
    static let environmentDefault: TargetEnvironment = TargetEnvironment.PRE
    #else
    static let environmentDefault: TargetEnvironment = TargetEnvironment.PRO
    #endif
    
    enum BaseUrlContext {
        case backend
        case webService
        case heroku
    }
    
    // MARK: - Headers
    static let headersAPI = [
        "x-rapidapi-host": "api-football-beta.p.rapidapi.com",
        "x-rapidapi-key": ""
    ]
    
    // MARK: - Endpoints
    // Endpoint of current season of a league
    static let endpointCurrentSeasonLeague = "leagues?current=true&id=%@"
    // Endpoint of league standing
    static let endpointLeagueStanding = "standings?season=%@&league=%@"
    // Endpoint of team statistics
    static let endpointTeamInformation = "teams?id=%@&season=%@&league=%@"
    // Endpoint of team matches of the actual season
    static let endpointTeamMatches = "fixtures?team=%@&season=%@&league=%@"
    // Endpoint of team statistics
    static let endpointTeamStatistics = "teams/statistics?team=%@&season=%@&league=%@"
    // Endpoint of team players
    static let endpointTeamPlayers = "players/squads?team=%@"
    // Endpoint of player statistics
    static let endpointPlayerStatistics = "players?id=%@&team=%@&season=%@&league=%@"
    // Endpoint of player trophies
    static let endpointPlayerTrophies = "trophies?player=%@"
    // Endpoint of season rounds
    static let endpointSeasonRounds = "fixtures/rounds?season=%@&league=%@"
    // Endpoint of all matches of a season
    static let endpointMatchesAllSeason = "fixtures?season=%@&league=%@"
    // Endpoint of matches of a round of a season
    static let endpointMatchesRound = "fixtures?season=%@&league=%@&round=%@"
    // Endpoint of current season round
    static let endpointCurrentRoundSeason = "fixtures/rounds?season=%@&league=%@&current=true"
    // Endpoint of match statistics
    static let endpointMatchStatistics = "fixtures/statistics?fixture=%@"
    // Endpoint of match events
    static let endpointMatchEvents = "fixtures/events?fixture=%@"
    // Endpoint of match lineups
    static let endpointMatchLineups = "fixtures/lineups?fixture=%@"
}

extension URLEnpoint {
    static func getUrlBase(urlContext: BaseUrlContext) -> String {
        switch urlContext {
        case .backend:
            switch self.environmentDefault {
            case .DEV:
                return ""
            case .PRE:
                return ""
            case .PRO:
                return ""
            }
        case .webService:
            switch self.environmentDefault {
            case .DEV:
                return ""
            case .PRE:
                return ""
            case .PRO:
                return "https://api-football-beta.p.rapidapi.com/"
            }
        case .heroku:
            switch self.environmentDefault {
            case .DEV:
                return ""
            case .PRE:
                return ""
            case .PRO:
                return "http://icospartan-app.herokuapp.com/"
            }
        }
    }
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: ".json") else { return nil }
        let data = try Data(contentsOf: url)
        let decodeModel = try JSONDecoder().decode(D.self, from: data)
        return decodeModel
    }
}

class Utils {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    static let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    static func roundStringDouble(number: String) -> String {
        let double = (number as NSString).doubleValue
        return String(format: "%.2f", double)
    }
    
    static func getRoundNumber(round: String) -> Int {
        let parts = round.components(separatedBy: "-")
        return Int(parts[1].trimmingCharacters(in: .whitespaces)) ?? 0
    }
    
    static func getPlayerPositionColor(position: String) -> Color {
        switch position {
        case PlayerPosition.Goalkeeper.rawValue:
            return Color.blue
        case PlayerPosition.Defender.rawValue:
            return Color.yellow
        case PlayerPosition.Midfielder.rawValue:
            return Color.green
        case PlayerPosition.Attacker.rawValue:
            return Color.red
        default:
            return Color.green.opacity(0.0)
        }
    }
    
    static func getPlayerPositionColorShortName(position: String) -> Color {
        switch position {
        case "G":
            return Color.blue
        case "D":
            return Color.yellow
        case "M":
            return Color.green
        case "F":
            return Color.red
        default:
            return Color.green.opacity(0.0)
        }
    }
    
    static func transformDataResponseLeagueToCurrentSeasonLeagueModelView(data: [ResponseLeague]?) -> CurrentSeasonLeagueModelView?{
        var currentSeasonLeague: CurrentSeasonLeagueModelView? = nil
        
        if let dataUnw = data{
            guard dataUnw.count > 0 else { return nil }
            if let seasonData = dataUnw[0].seasons, let leagueData = dataUnw[0].league, let countryData = dataUnw[0].country {
                guard seasonData.count > 0 else { return nil }
                currentSeasonLeague = CurrentSeasonLeagueModelView(id: leagueData.id,
                                                                   name: leagueData.name,
                                                                   type: leagueData.type,
                                                                   logo: leagueData.logo,
                                                                   year: seasonData[0].year ,
                                                                   start: seasonData[0].start,
                                                                   end: seasonData[0].end,
                                                                   nameCountry: countryData.name,
                                                                   codeCountry: countryData.code,
                                                                   flag: countryData.flag,
                                                                   standing: nil)
            }else{
                return nil
            }
        }
        
        return currentSeasonLeague
    }
    
    static func transformDataTeamMatchesToMatchModelView(data: TeamMatchesServerModel?) -> [MatchViewModel]?{
        var matchesTeam: [MatchViewModel] = []
        
        if let dataUnw = data?.response{
            for match in dataUnw {
                let newMatch = MatchViewModel(id: match.fixture?.id,
                                              referee: match.fixture?.referee,
                                              timezone: match.fixture?.timezone,
                                              date: match.fixture?.date,
                                              timestamp: match.fixture?.timestamp,
                                              stadiumId: match.fixture?.venue?.id,
                                              nameStadium: match.fixture?.venue?.name,
                                              city: match.fixture?.venue?.city,
                                              status: match.fixture?.status,
                                              leagueId: match.league?.id,
                                              leagueName: match.league?.name,
                                              season: match.league?.season,
                                              round: match.league?.round,
                                              teams: match.teams,
                                              goals: match.goals,
                                              score: match.score)
                matchesTeam.append(newMatch)
            }
        }else{
            return nil
        }
        
        return matchesTeam
    }
}

