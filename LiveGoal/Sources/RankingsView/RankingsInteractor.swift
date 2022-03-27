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
protocol RankingsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String)
    func fetchDataTopPlayerScorersInteractor(season: Int, idLeague: Int)
    func fetchDataTopPlayerAssistsInteractor(season: Int, idLeague: Int)
    func fetchDataTopPlayerYellowCardsInteractor(season: Int, idLeague: Int)
    func fetchDataTopPlayerRedCardsInteractor(season: Int, idLeague: Int)
}

// Output Provider
protocol RankingsProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>)
    func setInfoTopPlayerScorers(completion: Result<RankingPlayersServerModel?, NetworkError>)
    func setInfoTopPlayerAssists(completion: Result<RankingPlayersServerModel?, NetworkError>)
    func setInfoTopPlayerYellowCards(completion: Result<RankingPlayersServerModel?, NetworkError>)
    func setInfoTopPlayerRedCards(completion: Result<RankingPlayersServerModel?, NetworkError>)
}


final class RankingsInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: RankingsInteractorOutputProtocol?{
        super.baseViewModel as? RankingsInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: RankingsProviderInputProtocol?{
        super.baseProvider as? RankingsProviderInputProtocol
    }
    
    func transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: [RankingPlayer]?) -> [PlayerDetailStatisticsModelView]?{
        var players: [PlayerDetailStatisticsModelView] = []
        if let dataUnw = data{
            if dataUnw.count > 0{
                for player in dataUnw {
                    if let playerUnw = player.player, let statisticsUnw = player.statistics {
                        if statisticsUnw.count > 0 {
                            let model =  PlayerDetailStatisticsModelView(id: playerUnw.id,
                                                                         player: playerUnw,
                                                                         teamId: statisticsUnw[0].team?.id,
                                                                         teamName: statisticsUnw[0].team?.name,
                                                                         logoTeamUrl: statisticsUnw[0].team?.logoUrl,
                                                                         games: statisticsUnw[0].games,
                                                                         shots: statisticsUnw[0].shots,
                                                                         goals: statisticsUnw[0].goals,
                                                                         fouls: statisticsUnw[0].fouls,
                                                                         cards: statisticsUnw[0].cards)
                            players.append(model)
                        }
                    }
                }
            }
        }
        
        return players
    }

    
}

// Input del Interactor
extension RankingsInteractor: RankingsInteractorInputProtocol {
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String) {
        self.provider?.fetchDataCurrentSeasonLeagueProvider(idLeague: idLeague)
    }
    
    func fetchDataTopPlayerScorersInteractor(season: Int, idLeague: Int) {
        self.provider?.fetchDataTopPlayerScorersProvider(season: season, idLeague: idLeague)
    }
    
    func fetchDataTopPlayerAssistsInteractor(season: Int, idLeague: Int) {
        self.provider?.fetchDataTopPlayerAssistsProvider(season: season, idLeague: idLeague)
    }
    
    func fetchDataTopPlayerYellowCardsInteractor(season: Int, idLeague: Int) {
        self.provider?.fetchDataTopPlayerYellowCardsProvider(season: season, idLeague: idLeague)
    }
    
    func fetchDataTopPlayerRedCardsInteractor(season: Int, idLeague: Int) {
        self.provider?.fetchDataTopPlayerRedCardsProvider(season: season, idLeague: idLeague)
    }
    

    
    
}

// Output Provider
extension RankingsInteractor: RankingsProviderOutputProtocol{
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationCurrentSeasonLeague(data: Utils.transformDataResponseLeagueToCurrentSeasonLeagueModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoTopPlayerScorers(completion: Result<RankingPlayersServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationTopPlayerScorers(data: self.transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoTopPlayerAssists(completion: Result<RankingPlayersServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationTopPlayerAssists(data: self.transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoTopPlayerYellowCards(completion: Result<RankingPlayersServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationTopPlayerYellowCards(data: self.transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoTopPlayerRedCards(completion: Result<RankingPlayersServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationTopPlayerRedCards(data: self.transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    

    
    
}
