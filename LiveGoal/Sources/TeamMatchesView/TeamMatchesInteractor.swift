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
protocol TeamMatchesInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataTeamMatchesInteractor()
}

// Output Provider
protocol TeamMatchesProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoTeamMatches(completion: Result<TeamMatchesServerModel?, NetworkError>)
}


final class TeamMatchesInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: TeamMatchesInteractorOutputProtocol?{
        super.baseViewModel as? TeamMatchesInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: TeamMatchesProviderInputProtocol?{
        super.baseProvider as? TeamMatchesProviderInputProtocol
    }

    func transformDataTeamMatchesToMatchModelView(data: TeamMatchesServerModel?) -> [MatchViewModel]?{
        var matchesTeam: [MatchViewModel] = []
        
        if let dataUnw = data?.response{
            for match in dataUnw {
                let newMatch = MatchViewModel(id: match.fixture?.id,
                                              referee: match.fixture?.referee,
                                              timezone: match.fixture?.timezone,
                                              date: match.fixture?.date,
                                              timestamp: match.fixture?.timestamp,
                                              stadiumId: match.fixture?.venue?.id,
                                              nameStadium: match.fixture?.venue?.name,
                                              city: match.fixture?.venue?.city,
                                              status: match.fixture?.status,
                                              leagueId: match.league?.id,
                                              leagueName: match.league?.name,
                                              season: match.league?.season,
                                              round: match.league?.round,
                                              teams: match.teams,
                                              goals: match.goals,
                                              score: match.score)
                matchesTeam.append(newMatch)
            }
        }else{
            return nil
        }
        
        return matchesTeam
    }
}

// Input del Interactor
extension TeamMatchesInteractor: TeamMatchesInteractorInputProtocol {
    func fetchDataTeamMatchesInteractor() {
        self.provider?.fetchDataTeamMatchesProvider()
    }
}

// Output Provider
extension TeamMatchesInteractor: TeamMatchesProviderOutputProtocol{
    func setInfoTeamMatches(completion: Result<TeamMatchesServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationTeamMatches(data: Utils.transformDataTeamMatchesToMatchModelView(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
}
