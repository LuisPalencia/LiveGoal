/*
 
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation

// Input del Interactor
protocol DetailMatchInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataMatchStatisticsInteractor(idMatch: Int)
    func fetchDataMatchEventsInteractor(idMatch: Int)
    func fetchDataMatchLineupsInteractor(idMatch: Int)
}

// Output Provider
protocol DetailMatchProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInformationMatchStatistics(completion: Result<MatchStatisticsServerModel?, NetworkError>)
    func setInformationMatchEvents(completion: Result<MatchEventsServerModel?, NetworkError>)
    func setInformationMatchLineups(completion: Result<MatchLineupsServerModel?, NetworkError>)
}


final class DetailMatchInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: DetailMatchInteractorOutputProtocol?{
        super.baseViewModel as? DetailMatchInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: DetailMatchProviderInputProtocol?{
        super.baseProvider as? DetailMatchProviderInputProtocol
    }

    func transformMatchStatisticsServerModelToMatchStatisticsViewModel(data: MatchStatisticsServerModel?) -> MatchStatisticsViewModel?{
        if let dataUnw = data?.response {
            if dataUnw.count == 2 {
                var model = MatchStatisticsViewModel()
                model.teamIdHome = dataUnw[0].team?.id
                
                for homeTeamStatistic in dataUnw[0].statistics ?? []{
                    
                    var valueInt: Int? = nil
                    var valueString: String? = nil
                    
                    switch homeTeamStatistic.value {
                    case let .integer(data):
                        valueInt = data
                    case let .string(data):
                        valueString = data
                    case .null:
                        break
                    default:
                        break
                    }
                    
                    switch homeTeamStatistic.type?.lowercased() {
                    case MatchStatisticTypes.Shots_on_Goal.rawValue.lowercased():
                        
                        model.shotsOnGoalHome = valueInt
                        
                    case MatchStatisticTypes.Shots_off_Goal.rawValue.lowercased():
                        model.shotsOffGoalHome = valueInt
                        
                    case MatchStatisticTypes.Total_Shots.rawValue.lowercased():
                        model.totalShotsHome = valueInt
                        
                    case MatchStatisticTypes.Blocked_Shots.rawValue.lowercased():
                        model.blockedShotsHome = valueInt
                        
                    case MatchStatisticTypes.Shots_insidebox.rawValue.lowercased():
                        model.shotsInsideBoxHome = valueInt
                        
                    case MatchStatisticTypes.Shots_outsidebox.rawValue.lowercased():
                        model.shotsOutsideBoxHome = valueInt
                        
                    case MatchStatisticTypes.Fouls.rawValue.lowercased():
                        model.foulsHome = valueInt
                        
                    case MatchStatisticTypes.Corner_Kicks.rawValue.lowercased():
                        model.cornersHome = valueInt
                        
                    case MatchStatisticTypes.Offsides.rawValue.lowercased():
                        model.offsidesHome = valueInt
                        
                    case MatchStatisticTypes.Ball_Possession.rawValue.lowercased():
                        if var valueStringUnw = valueString {
                            if !valueStringUnw.isEmpty && valueStringUnw.last == "%" {
                                valueStringUnw.removeLast()
                            }
                            if Int(valueStringUnw) != nil {
                                model.ballPossessionHome = Int(valueStringUnw)
                            }
                        }
                        
                    case MatchStatisticTypes.Yellow_Cards.rawValue.lowercased():
                        model.yellowCardsHome = valueInt
                        
                    case MatchStatisticTypes.Red_Cards.rawValue.lowercased():
                        model.redCardsHome = valueInt
                        
                    case MatchStatisticTypes.Goalkeeper_Saves.rawValue.lowercased():
                        model.goalkeeperSavesHome = valueInt
                        
                    case MatchStatisticTypes.Total_passes.rawValue.lowercased():
                        model.totalPassesHome = valueInt
                        
                    case MatchStatisticTypes.Passes_accurate.rawValue.lowercased():
                        model.totalSuccessfulPassesHome = valueInt
                        
                    case MatchStatisticTypes.Passes_Percentage.rawValue.lowercased():
                        if var valueStringUnw = valueString {
                            if !valueStringUnw.isEmpty && valueStringUnw.last == "%" {
                                valueStringUnw.removeLast()
                            }
                            if Int(valueStringUnw) != nil {
                                model.passesSuccessfulPercentageHome = Int(valueStringUnw)
                            }
                        }
                        
                    default:
                        print("Error decoding: \(homeTeamStatistic.type ?? "")")
                    }
                }
                
                model.teamIdAway = dataUnw[1].team?.id
                
                for awayTeamStatistic in dataUnw[1].statistics ?? []{
                    
                    var valueInt: Int? = nil
                    var valueString: String? = nil
                    
                    switch awayTeamStatistic.value {
                    case let .integer(data):
                        valueInt = data
                    case let .string(data):
                        valueString = data
                    case .null:
                        break
                    default:
                        break
                    }
                    
                    switch awayTeamStatistic.type?.lowercased() {
                    case MatchStatisticTypes.Shots_on_Goal.rawValue.lowercased():
                        model.shotsOnGoalAway = valueInt
                        
                    case MatchStatisticTypes.Shots_off_Goal.rawValue.lowercased():
                        model.shotsOffGoalAway = valueInt
                        
                    case MatchStatisticTypes.Total_Shots.rawValue.lowercased():
                        model.totalShotsAway = valueInt
                        
                    case MatchStatisticTypes.Blocked_Shots.rawValue.lowercased():
                        model.blockedShotsAway = valueInt
                        
                    case MatchStatisticTypes.Shots_insidebox.rawValue.lowercased():
                        model.shotsInsideBoxAway = valueInt
                        
                    case MatchStatisticTypes.Shots_outsidebox.rawValue.lowercased():
                        model.shotsOutsideBoxAway = valueInt
                        
                    case MatchStatisticTypes.Fouls.rawValue.lowercased():
                        model.foulsAway = valueInt
                        
                    case MatchStatisticTypes.Corner_Kicks.rawValue.lowercased():
                        model.cornersAway = valueInt
                        
                    case MatchStatisticTypes.Offsides.rawValue.lowercased():
                        model.offsidesAway = valueInt
                        
                    case MatchStatisticTypes.Ball_Possession.rawValue.lowercased():
                        if var valueStringUnw = valueString {
                            if !valueStringUnw.isEmpty && valueStringUnw.last == "%" {
                                valueStringUnw.removeLast()
                            }
                            if Int(valueStringUnw) != nil {
                                model.ballPossessionAway = Int(valueStringUnw)
                            }
                        }
                        
                    case MatchStatisticTypes.Yellow_Cards.rawValue.lowercased():
                        model.yellowCardsAway = valueInt
                        
                    case MatchStatisticTypes.Red_Cards.rawValue.lowercased():
                        model.redCardsAway = valueInt
                        
                    case MatchStatisticTypes.Goalkeeper_Saves.rawValue.lowercased():
                        model.goalkeeperSavesAway = valueInt
                        
                    case MatchStatisticTypes.Total_passes.rawValue.lowercased():
                        model.totalPassesAway = valueInt
                        
                    case MatchStatisticTypes.Passes_accurate.rawValue.lowercased():
                        model.totalSuccessfulPassesAway = valueInt
                        
                    case MatchStatisticTypes.Passes_Percentage.rawValue.lowercased():
                        if var valueStringUnw = valueString {
                            if !valueStringUnw.isEmpty && valueStringUnw.last == "%" {
                                valueStringUnw.removeLast()
                            }
                            if Int(valueStringUnw) != nil {
                                model.passesSuccessfulPercentageAway = Int(valueStringUnw)
                            }
                        }
                        
                        
                    default:
                        print("Error decoding: \(awayTeamStatistic.type ?? "")")
                    }
                }
                
                return model
            }
            
        }
        return nil
    }
    
//    func sortPlayersLineup(data: [MatchLineupTeam]?){
//        if let dataUnw = data {
//            if dataUnw.count == 2 {
//                var localTeam = dataUnw[0]
//                var awayTeam = dataUnw[1]
//
//                if localTeam.startXI != nil, localTeam.substitutes != nil, awayTeam.startXI != nil, awayTeam.substitutes != nil {
//                    var startHomeSorted: [PlayerMatch] = []
//                    var startAwaySorted: [PlayerMatch] = []
//                    var substitutesHomeSorted: [PlayerMatch] = []
//                    var substitutesAwaySorted: [PlayerMatch] = []
//
//                    startHomeSorted.append += localTeam.goalkeepersStart
//                }
//
//
//
//
//            }
//        }
//    }
}

// Input del Interactor
extension DetailMatchInteractor: DetailMatchInteractorInputProtocol {
    
    func fetchDataMatchStatisticsInteractor(idMatch: Int){
        self.provider?.fetchDataMatchStatisticsProvider(idMatch: idMatch)
    }
    
    func fetchDataMatchEventsInteractor(idMatch: Int){
        self.provider?.fetchDataMatchEventsProvider(idMatch: idMatch)
    }
    
    func fetchDataMatchLineupsInteractor(idMatch: Int){
        self.provider?.fetchDataMatchLineupsProvider(idMatch: idMatch)
    }
    
}

// Output Provider
extension DetailMatchInteractor: DetailMatchProviderOutputProtocol{
    func setInformationMatchStatistics(completion: Result<MatchStatisticsServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationMatchStatistics(data: self.transformMatchStatisticsServerModelToMatchStatisticsViewModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInformationMatchEvents(completion: Result<MatchEventsServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationMatchEvents(data: data?.response ?? [])
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInformationMatchLineups(completion: Result<MatchLineupsServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            if data?.response?.count == 2 {
                self.viewModel?.setInformationMatchLineups(data: data?.response ?? [])
            }else{
                debugPrint("Error when obtaining lineups")
            }
            
        case .failure(let error):
            debugPrint(error)
        }
    }
    
}
