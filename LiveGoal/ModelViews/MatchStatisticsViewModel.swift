//
//  MatchStatisticsViewModel.swift
//  FootballApp
//
//  Created by CICE on 23/03/2022.
//

import Foundation

struct MatchStatisticsViewModel: Identifiable {
    var id: Int?
    
    var teamIdHome: Int?
    var shotsOnGoalHome: Int?
    var shotsOffGoalHome: Int?
    var totalShotsHome: Int?
    var blockedShotsHome: Int?
    var shotsInsideBoxHome: Int?
    var shotsOutsideBoxHome: Int?
    var foulsHome: Int?
    var cornersHome: Int?
    var offsidesHome: Int?
    var ballPossessionHome: Int?
    var yellowCardsHome: Int?
    var redCardsHome: Int?
    var goalkeeperSavesHome: Int?
    var totalPassesHome: Int?
    var totalSuccessfulPassesHome: Int?
    var passesSuccessfulPercentageHome: Int?
    
    var teamIdAway: Int?
    var shotsOnGoalAway: Int?
    var shotsOffGoalAway: Int?
    var totalShotsAway: Int?
    var blockedShotsAway: Int?
    var shotsInsideBoxAway: Int?
    var shotsOutsideBoxAway: Int?
    var foulsAway: Int?
    var cornersAway: Int?
    var offsidesAway: Int?
    var ballPossessionAway: Int?
    var yellowCardsAway: Int?
    var redCardsAway: Int?
    var goalkeeperSavesAway: Int?
    var totalPassesAway: Int?
    var totalSuccessfulPassesAway: Int?
    var passesSuccessfulPercentageAway: Int?
    
    var possessionHomeDecimal: Float {
        return Float(ballPossessionHome ?? 0) / 100.0
    }
    
    var totalShotsHomePercentageDecimal: Float {
        if (totalShotsHome == nil || totalShotsHome == 0) && (totalShotsAway == nil || totalShotsAway == 0) {
            return 0.5
        }
        return Float(totalShotsHome ?? 0) / (Float(totalShotsHome ?? 0) + (Float(totalShotsAway ?? 0)))
    }
    
    var shotsOnGoalHomePercentageDecimal: Float {
        if (shotsOnGoalHome == nil || shotsOnGoalHome == 0) && (shotsOnGoalAway == nil || shotsOnGoalAway == 0) {
            return 0.5
        }
        return Float(shotsOnGoalHome ?? 0) / (Float(shotsOnGoalHome ?? 0) + (Float(shotsOnGoalAway ?? 0)))
    }
    
    var shotsOffGoalHomePercentageDecimal: Float {
        if (shotsOffGoalHome == nil || shotsOffGoalHome == 0) && (shotsOffGoalAway == nil || shotsOffGoalAway == 0) {
            return 0.5
        }
        return Float(shotsOffGoalHome ?? 0) / (Float(shotsOffGoalHome ?? 0) + (Float(shotsOffGoalAway ?? 0)))
    }
    
    var cornersHomePercentageDecimal: Float {
        if (cornersHome == nil || cornersHome == 0) && (cornersAway == nil || cornersAway == 0) {
            return 0.5
        }
        return Float(cornersHome ?? 0) / (Float(cornersHome ?? 0) + (Float(cornersAway ?? 0)))
    }
    
    var offsidesHomePercentageDecimal: Float {
        if (offsidesHome == nil || offsidesHome == 0) && (offsidesAway == nil || offsidesAway == 0) {
            return 0.5
        }
        return Float(offsidesHome ?? 0) / (Float(offsidesAway ?? 0) + (Float(offsidesHome ?? 0)))
    }
    
    var goalkeeperSavesHomePercentageDecimal: Float {
        if (goalkeeperSavesHome == nil || goalkeeperSavesHome == 0) && (goalkeeperSavesAway == nil || goalkeeperSavesAway == 0) {
            return 0.5
        }
        return Float(goalkeeperSavesHome ?? 0) / (Float(goalkeeperSavesHome ?? 0) + (Float(goalkeeperSavesAway ?? 0)))
    }
    
    var yellowCardsHomePercentageDecimal: Float {
        if (yellowCardsHome == nil || yellowCardsHome == 0) && (yellowCardsAway == nil || yellowCardsAway == 0) {
            return 0.5
        }
        return Float(yellowCardsHome ?? 0) / (Float(yellowCardsHome ?? 0) + (Float(yellowCardsAway ?? 0)))
    }
    
    var redCardsHomePercentageDecimal: Float {
        if (redCardsHome == nil || redCardsHome == 0) && (redCardsAway == nil || redCardsAway == 0) {
            return 0.5
        }
        return Float(redCardsHome ?? 0) / (Float(redCardsHome ?? 0) + (Float(redCardsAway ?? 0)))
    }
    
    var totalPasesHomePercentageDecimal: Float {
        if (totalPassesHome == nil || totalPassesHome == 0) && (totalPassesAway == nil || totalPassesAway == 0) {
            return 0.5
        }
        return Float(totalPassesHome ?? 0) / (Float(totalPassesHome ?? 0) + (Float(totalPassesAway ?? 0)))
    }
    
    var totalSuccessfulPasesHomePercentageDecimal: Float {
        if (totalSuccessfulPassesHome == nil || totalSuccessfulPassesHome == 0) && (totalSuccessfulPassesAway == nil || totalSuccessfulPassesAway == 0) {
            return 0.5
        }
        return Float(totalSuccessfulPassesHome ?? 0) / (Float(totalSuccessfulPassesHome ?? 0) + (Float(totalSuccessfulPassesAway ?? 0)))
    }
}
