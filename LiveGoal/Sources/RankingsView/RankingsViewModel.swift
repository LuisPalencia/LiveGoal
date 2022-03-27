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

// Output del Interactor
protocol RankingsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInformationCurrentSeasonLeague(data: CurrentSeasonLeagueModelView?)
    func setInformationTopPlayerScorers(data: [PlayerDetailStatisticsModelView]?)
    func setInformationTopPlayerAssists(data: [PlayerDetailStatisticsModelView]?)
    func setInformationTopPlayerYellowCards(data: [PlayerDetailStatisticsModelView]?)
    func setInformationTopPlayerRedCards(data: [PlayerDetailStatisticsModelView]?)
}

final class RankingsViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: RankingsInteractorInputProtocol?{
        super.baseInteractor as? RankingsInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    @Published var dataCurrentSeasonLeague: CurrentSeasonLeagueModelView?
    @Published var dataTopPlayerScorers: [PlayerDetailStatisticsModelView] = []
    @Published var dataTopPlayerAssists: [PlayerDetailStatisticsModelView] = []
    @Published var dataTopPlayerYellowCards: [PlayerDetailStatisticsModelView] = []
    @Published var dataTopPlayerRedCards: [PlayerDetailStatisticsModelView] = []
    
    // MARK: - Metodospublicos
    func fetchData(){
        self.interactor?.fetchDataCurrentSeasonLeagueInteractor(idLeague: Constants.laLigaId)
    }
    
    func getTopPlayersFromSecond(type: RankingTypes) -> [PlayerDetailStatisticsModelView] {
        var array: [PlayerDetailStatisticsModelView]
        switch type {
        case .Goals:
            array = self.dataTopPlayerScorers
        case .Assists:
            array = self.dataTopPlayerAssists
        case .YellowCards:
            array = self.dataTopPlayerYellowCards
        case .RedCards:
            array = self.dataTopPlayerRedCards
        }
        
        array.removeFirst()
        return array
    }
    
}

// Output del Interactor
extension RankingsViewModel: RankingsInteractorOutputProtocol {
    
    func setInformationCurrentSeasonLeague(data: CurrentSeasonLeagueModelView?) {
        guard let dataUnw = data else {
            return
        }
        self.dataCurrentSeasonLeague = dataUnw
        
        self.interactor?.fetchDataTopPlayerScorersInteractor(season: dataUnw.year ?? 0, idLeague: dataUnw.id ?? 0)
        self.interactor?.fetchDataTopPlayerAssistsInteractor(season: dataUnw.year ?? 0, idLeague: dataUnw.id ?? 0)
        self.interactor?.fetchDataTopPlayerYellowCardsInteractor(season: dataUnw.year ?? 0, idLeague: dataUnw.id ?? 0)
        self.interactor?.fetchDataTopPlayerRedCardsInteractor(season: dataUnw.year ?? 0, idLeague: dataUnw.id ?? 0)
    }
    
    func setInformationTopPlayerScorers(data: [PlayerDetailStatisticsModelView]?){
        self.dataTopPlayerScorers = data ?? []
    }
    
    func setInformationTopPlayerAssists(data: [PlayerDetailStatisticsModelView]?){
        self.dataTopPlayerAssists = data ?? []
    }
    
    func setInformationTopPlayerYellowCards(data: [PlayerDetailStatisticsModelView]?){
        self.dataTopPlayerYellowCards = data ?? []
    }

    func setInformationTopPlayerRedCards(data: [PlayerDetailStatisticsModelView]?){
        self.dataTopPlayerRedCards = data ?? []
    }
    
}


