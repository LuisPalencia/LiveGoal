//
//  TeamStatisticsServerModel.swift
//  LiveGoal
//
//  Created by CICE on 28/03/2022.
//

import Foundation

// MARK: - TeamStatisticsServerModel
struct TeamStatisticsServerModel: Codable {
    let teamStatisticsServerModelGet: String?
    let parameters: Parameters?
    let errors: [JSONAny]?
    let results: Int?
    let paging: Paging?
    let response: TeamStatistics?

    enum CodingKeys: String, CodingKey {
        case teamStatisticsServerModelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}

// MARK: - Response
struct TeamStatistics: Codable {
    let league: League?
    let team: Team?
    let form: String?
    let fixtures: FixturesTeamStatistics?
    let goals: GoalsTeamStatistics?
    let biggest: BiggestTeamStatistics?
    let cleanSheet: HomeAwayTotalStatistic?
    let failedToScore: HomeAwayTotalStatistic?
    let penalty: PenaltyTeamStatistic?
    let lineups: [LineupTeam]?
    let cards: CardsTeamStatistics?

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case team = "team"
        case form = "form"
        case fixtures = "fixtures"
        case goals = "goals"
        case biggest = "biggest"
        case cleanSheet = "clean_sheet"
        case failedToScore = "failed_to_score"
        case penalty = "penalty"
        case lineups = "lineups"
        case cards = "cards"
    }
}

// MARK: - Biggest
struct BiggestTeamStatistics: Codable {
    let streak: BiggestStreak?
    let wins: BiggestWinsLoses?
    let loses: BiggestWinsLoses?
    let goals: BiggestGoals?

    enum CodingKeys: String, CodingKey {
        case streak = "streak"
        case wins = "wins"
        case loses = "loses"
        case goals = "goals"
    }
}

// MARK: - BiggestGoals
struct BiggestGoals: Codable {
    let goalsFor: PurpleAgainst?
    let against: PurpleAgainst?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against = "against"
    }
}

// MARK: - PurpleAgainst
struct PurpleAgainst: Codable {
    let home: Int?
    let away: Int?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}

// MARK: - Loses
struct BiggestWinsLoses: Codable {
    let home: String?
    let away: String?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}

// MARK: - Streak
struct BiggestStreak: Codable {
    let wins: Int?
    let draws: Int?
    let loses: Int?

    enum CodingKeys: String, CodingKey {
        case wins = "wins"
        case draws = "draws"
        case loses = "loses"
    }
}

// MARK: - Cards
struct CardsTeamStatistics: Codable {
    let yellow: MinuteStatistics?
    let red: MinuteStatistics?

    enum CodingKeys: String, CodingKey {
        case yellow = "yellow"
        case red = "red"
    }
    
    
    var totalYellowCards: Int {
        var total = (yellow?.the015?.total ?? 0) + (yellow?.the1630?.total ?? 0) + (yellow?.the3145?.total ?? 0)
        total = total + (yellow?.the4660?.total ?? 0) + (yellow?.the6175?.total ?? 0)
        total = total + (yellow?.the7690?.total ?? 0) + (yellow?.the91105?.total ?? 0)
        total = total + (yellow?.the106120?.total ?? 0) + (yellow?.empty?.total ?? 0)
        return total
    }
    
    var totalRedCards: Int {
        var total = (red?.the015?.total ?? 0) + (red?.the1630?.total ?? 0) + (red?.the3145?.total ?? 0)
        total = total + (red?.the4660?.total ?? 0) + (red?.the6175?.total ?? 0)
        total = total + (red?.the7690?.total ?? 0) + (red?.the91105?.total ?? 0)
        total = total + (red?.the106120?.total ?? 0) + (red?.empty?.total ?? 0)
        return total
    }
}



// MARK: - Yellow
struct MinuteStatistics: Codable {
    let the015: StatisticTotalPercentage?
    let the1630: StatisticTotalPercentage?
    let the3145: StatisticTotalPercentage?
    let the4660: StatisticTotalPercentage?
    let the6175: StatisticTotalPercentage?
    let the7690: StatisticTotalPercentage?
    let the91105: StatisticTotalPercentage?
    let the106120: StatisticTotalPercentage?
    let empty: StatisticTotalPercentage?

    enum CodingKeys: String, CodingKey {
        case the015 = "0-15"
        case the1630 = "16-30"
        case the3145 = "31-45"
        case the4660 = "46-60"
        case the6175 = "61-75"
        case the7690 = "76-90"
        case the91105 = "91-105"
        case the106120 = "106-120"
        case empty = ""
    }
}

// MARK: - Missed
struct StatisticTotalPercentage: Codable {
    let total: Int?
    let percentage: String?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case percentage = "percentage"
    }
}

// MARK: - CleanSheet
struct HomeAwayTotalStatistic: Codable {
    let home: Int?
    let away: Int?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
        case total = "total"
    }
    
    var homePercentageDecimal: Float {
        if (home == nil || home == 0) && (away == nil || away == 0) {
            return 0.5
        }
        return Float(home ?? 0) / Float(total ?? 0)
    }
}

// MARK: - Fixtures
struct FixturesTeamStatistics: Codable {
    let played: HomeAwayTotalStatistic?
    let wins: HomeAwayTotalStatistic?
    let draws: HomeAwayTotalStatistic?
    let loses: HomeAwayTotalStatistic?

    enum CodingKeys: String, CodingKey {
        case played = "played"
        case wins = "wins"
        case draws = "draws"
        case loses = "loses"
    }
}

// MARK: - ResponseGoals
struct GoalsTeamStatistics: Codable {
    let goalsFor: GoalsTeam?
    let against: GoalsTeam?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against = "against"
    }
}

// MARK: - FluffyAgainst
struct GoalsTeam: Codable {
    let total: HomeAwayTotalStatistic?
    let average: AverageGoalsTeam?
    let minute: MinuteStatistics?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case average = "average"
        case minute = "minute"
    }
}

// MARK: - Average
struct AverageGoalsTeam: Codable {
    let home: String?
    let away: String?
    let total: String?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
        case total = "total"
    }
}

// MARK: - Lineup
struct LineupTeam: Codable, Identifiable {
    let id = UUID()
    let formation: String?
    let played: Int?

    enum CodingKeys: String, CodingKey {
        case formation = "formation"
        case played = "played"
    }
}

// MARK: - Penalty
struct PenaltyTeamStatistic: Codable {
    let scored: StatisticTotalPercentage?
    let missed: StatisticTotalPercentage?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case scored = "scored"
        case missed = "missed"
        case total = "total"
    }
}

extension TeamStatisticsServerModel {
    
    static var stubbedTeamStatistics: TeamStatistics {
        let results: TeamStatisticsServerModel? = try? Bundle.main.loadAndDecodeJSON(filename: "TeamStatistics")
        return (results?.response)!
    }

}
