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
protocol LeagueRoundsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String)
    func fetchDataLeagueRoundsInteractor(idLeague: Int, season: Int)
    func fetchDataLeagueAllMatchesInteractor(idLeague: Int, season: Int)
}

// Output Provider
protocol LeagueRoundsProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>)
    func setInformationLeagueRounds(completion: Result<SeasonRoundsServerModel?, NetworkError>)
    func setInformationLeagueAllMatches(completion: Result<TeamMatchesServerModel?, NetworkError>)
}


final class LeagueRoundsInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: LeagueRoundsInteractorOutputProtocol?{
        super.baseViewModel as? LeagueRoundsInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: LeagueRoundsProviderInputProtocol?{
        super.baseProvider as? LeagueRoundsProviderInputProtocol
    }

    func transformSeasonRoundsToSeasonRoundsModelView(data: SeasonRoundsServerModel?) -> [SeasonRoundsModelView]?{
        var seasonRounds: [SeasonRoundsModelView] = []
        
        if let dataUnw = data?.response {
            for round in dataUnw {
                let seasonRound = SeasonRoundsModelView(id: Utils.getRoundNumber(round: round), roundName: round)
                seasonRounds.append(seasonRound)
            }
            return seasonRounds
        }
        
        return nil
    }
    

    
    func divideMatchesInRounds(data: [MatchViewModel]?) -> [Int: [MatchViewModel]]?{
        var roundMatches: [Int: [MatchViewModel]] = [:]
        
        if let dataUnw = data {
            for match in dataUnw {
                let round = Utils.getRoundNumber(round: match.round ?? "")
                if roundMatches[round] == nil {
                    roundMatches[round] = []
                }
                roundMatches[round]?.append(match)
            }
            
            return roundMatches
        }
        
        return nil
    }
    
}

// Input del Interactor
extension LeagueRoundsInteractor: LeagueRoundsInteractorInputProtocol {
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String) {
        self.provider?.fetchDataCurrentSeasonLeagueProvider(idLeague: idLeague)
    }
    
    func fetchDataLeagueRoundsInteractor(idLeague: Int, season: Int) {
        self.provider?.fetchDataLeagueRoundsProvider(idLeague: idLeague, season: season)
    }
    
    func fetchDataLeagueAllMatchesInteractor(idLeague: Int, season: Int) {
        self.provider?.fetchDataLeagueAllMatchesProvider(idLeague: idLeague, season: season)
    }
}

// Output Provider
extension LeagueRoundsInteractor: LeagueRoundsProviderOutputProtocol{
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationCurrentSeasonLeague(data: Utils.transformDataResponseLeagueToCurrentSeasonLeagueModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInformationLeagueRounds(completion: Result<SeasonRoundsServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationCurrentLeagueRounds(data: self.transformSeasonRoundsToSeasonRoundsModelView(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInformationLeagueAllMatches(completion: Result<TeamMatchesServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            let matches = Utils.transformDataTeamMatchesToMatchModelView(data: data)
            self.viewModel?.setInformationCurrentLeagueAllMatches(data: self.divideMatchesInRounds(data: matches))
        case .failure(let error):
            debugPrint(error)
        }
    }
}
