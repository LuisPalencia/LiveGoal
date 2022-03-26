//
//  MatchStatus.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import Foundation

enum MatchStatus: String {
    case time_to_be_defined = "TBD"
    case not_started = "NS"
    case first_half = "1H"
    case halftime = "HT"
    case second_half = "2H"
    case extra_time = "ET"
    case finished = "FT"
}
