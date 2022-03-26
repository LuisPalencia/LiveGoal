//
//  TeamViewModel.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import Foundation


struct TeamViewModel: Identifiable {
    // Team info
    let id: Int?
    let name: String?
    let country: String?
    let founded: Int?
    let logo: String?
    // Stadium
    let nameStadium: String?
    let address: String?
    let city: String?
    let capacity: Int?
    let imageStadium: String?
}

