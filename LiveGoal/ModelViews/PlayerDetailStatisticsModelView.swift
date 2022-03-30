//
//  PlayerDetailStatisticsModelView.swift
//  FootballApp
//
//  Created by CICE on 22/03/2022.
//

import Foundation

struct PlayerDetailStatisticsModelView: Identifiable {
    let id: Int?
    let player: Player?
    let teamId: Int?
    let teamName: String?
    let logoTeamUrl: URL?
    let games: GamesPlayer?
    let shots: ShotsPlayer?
    let goals: GoalsPlayer?
    let fouls: FoulsPlayer?
    let cards: CardsPlayer?
    
    let passes: PassesPlayer?
    let dribbles: DribblesPlayer?
    let penalty: PenaltyPlayer?
}
