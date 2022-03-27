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
protocol LeagueRoundsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInformationCurrentSeasonLeague(data: CurrentSeasonLeagueModelView?)
    func setInformationLeagueRounds(data: [SeasonRoundsModelView]?)
    func setInformationLeagueAllMatches(data: [Int: [MatchViewModel]]?)
    func setInformationCurrentLeagueRound(data: String)
}

final class LeagueRoundsViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: LeagueRoundsInteractorInputProtocol?{
        super.baseInteractor as? LeagueRoundsInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    @Published var dataCurrentSeasonLeague: CurrentSeasonLeagueModelView?
    @Published var dataLeagueRounds: [Int] = []
    @Published var dataMatchesLeague: [Int: [MatchViewModel]] = [:]
    @Published var dataCurrentLeagueRound: Int = 1
    
    var dataLeagueSeasonRounds: [SeasonRoundsModelView] = []
    
    
    // MARK: - Metodospublicos
    func fetchData(){
        self.interactor?.fetchDataCurrentSeasonLeagueInteractor(idLeague: Constants.laLigaId)
    }
    
    func getMatchesRoundSorted(round: Int) -> [MatchViewModel]?{
        return dataMatchesLeague[round]?.sorted(by: {
            $0.timestamp ?? 0 < $1.timestamp ?? 0
        })
    }
    
}

// Output del Interactor
extension LeagueRoundsViewModel: LeagueRoundsInteractorOutputProtocol {
    
    func setInformationCurrentSeasonLeague(data: CurrentSeasonLeagueModelView?) {
        guard let dataUnw = data else {
            return
        }
        self.dataCurrentSeasonLeague = dataUnw
        
        self.interactor?.fetchDataCurrentLeagueRound(idLeague: dataUnw.id ?? 0, season: dataUnw.year ?? 0)
        self.interactor?.fetchDataLeagueRoundsInteractor(idLeague: dataUnw.id ?? 0, season: dataUnw.year ?? 0)
        self.interactor?.fetchDataLeagueAllMatchesInteractor(idLeague: dataUnw.id ?? 0, season: dataUnw.year ?? 0)
    }
    
    func setInformationLeagueRounds(data: [SeasonRoundsModelView]?) {
        self.dataLeagueSeasonRounds = data ?? []
        var rounds: [Int] = []
        for seasonRound in self.dataLeagueSeasonRounds {
            rounds.append(seasonRound.id)
        }
        self.dataLeagueRounds.removeAll()
        self.dataLeagueRounds = rounds
        self.dataLeagueRounds.sort()
    }
    
    func setInformationLeagueAllMatches(data: [Int: [MatchViewModel]]?) {
        self.dataMatchesLeague = data ?? [:]
    }
    
    func setInformationCurrentLeagueRound(data: String) {
        self.dataCurrentLeagueRound = Utils.getRoundNumber(round: data)
    }
}


