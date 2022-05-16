//
//  Constants.swift
//  FootballApp
//
//  Created by CICE on 12/03/2022.
//

import Foundation

struct Constants{
    struct Api{
        static let apiKey2: [UInt8] = []
        static let apiKey1: [UInt8] = []
        
        static let apiKey: [UInt8] = []
        
        static let apiKey3: [UInt8] = []
        
    }
    
    static let laLigaId = "140"
    
    static func getApiKey() -> [UInt8] {
        let number = Int.random(in: 0..<4)
        switch number {
        case 0:
            return Api.apiKey
        case 1:
            return Api.apiKey1
        case 2:
            return Api.apiKey2
        default:
            return Api.apiKey3
        }
    }
    
    
}
