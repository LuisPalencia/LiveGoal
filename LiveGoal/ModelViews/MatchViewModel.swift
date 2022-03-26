//
//  MatchViewModel.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import Foundation

struct MatchViewModel: Identifiable {
    let id: Int?
    let referee: String?
    let timezone: String?
    let date: String?
    let timestamp: Int?
    
    let stadiumId: Int?
    let nameStadium: String?
    let city: String?
    
    let status: Status?
    
    let leagueId: Int?
    let leagueName: String?
    let season: Int?
    let round: String?
    
    let teams: Teams?
    let goals: GoalsMatch?
    let score: Score?
    
    var timestampToDate: Date {
        return Date(timeIntervalSince1970: Double(timestamp ?? 0))
    }
    
    var dateMatch: String {
        let date = Date(timeIntervalSince1970: Double(timestamp ?? 0))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm"
        return dateFormatter.string(from: date)
    }
}
