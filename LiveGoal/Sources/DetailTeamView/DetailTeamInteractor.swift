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
protocol DetailTeamInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataTeamInfoProvider()
    func fetchDataTeamPlayersProvider()
    func getCurrentSeason() -> Int
    func saveDataAsFavouriteInteractor(name: String, logo: String)
    func removeDataAsFavouriteInteractor(name: String, logo: String)
}

// Output Provider
protocol DetailTeamProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInformationTeam(completion: Result<TeamInfoServerModel?, NetworkError>)
    func setInfoTeamPlayers(completion: Result<TeamPlayersServerModel?, NetworkError>)
}


final class DetailTeamInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: DetailTeamInteractorOutputProtocol?{
        super.baseViewModel as? DetailTeamInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: DetailTeamProviderInputProtocol?{
        super.baseProvider as? DetailTeamProviderInputProtocol
    }
    
    func dividePlayersInPositions(data: [Player]?){
        var goalkeepers: [Player] = []
        var defenders: [Player] = []
        var midfielders: [Player] = []
        var attackers: [Player] = []
        var unknownPosition: [Player] = []
        
        if let dataUnw = data{
            for player in dataUnw {
                if let positionUnw = player.position {
                    switch positionUnw {
                    case PlayerPosition.Goalkeeper.rawValue:
                        goalkeepers.append(player)
                    case PlayerPosition.Defender.rawValue:
                        defenders.append(player)
                    case PlayerPosition.Midfielder.rawValue:
                        midfielders.append(player)
                    case PlayerPosition.Attacker.rawValue:
                        attackers.append(player)
                    default:
                        unknownPosition.append(player)
                    }
                }
            }
        }
        self.viewModel?.setInformationTeamPlayersGoalkeepers(data: goalkeepers)
        self.viewModel?.setInformationTeamPlayersDefenders(data: defenders)
        self.viewModel?.setInformationTeamPlayersMidfielders(data: midfielders)
        self.viewModel?.setInformationTeamPlayersAttackers(data: attackers)
        self.viewModel?.setInformationTeamPlayersUnknown(data: unknownPosition)
    }
    
}

// Input del Interactor
extension DetailTeamInteractor: DetailTeamInteractorInputProtocol {
    func fetchDataTeamInfoProvider(){
        self.provider?.fetchDataTeamInfoProvider()
    }
    
    func fetchDataTeamPlayersProvider() {
        self.provider?.fetchDataTeamPlayersProvider()
    }
    
    func getCurrentSeason() -> Int{
        return provider?.getCurrentSeason() ?? 0
    }
    
    func saveDataAsFavouriteInteractor(name: String, logo: String) {
        self.provider?.saveDataAsFavouriteProvider(name: name, logo: logo)
    }
    
    func removeDataAsFavouriteInteractor(name: String, logo: String) {
        self.provider?.removeDataAsFavouriteProvider(name: name, logo: logo)
    }
}

// Output Provider
extension DetailTeamInteractor: DetailTeamProviderOutputProtocol{
    
    
    func setInformationTeam(completion: Result<TeamInfoServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            if let dataUnw = data?.response {
                if dataUnw.count > 0 {
                    self.viewModel?.setInformationTeam(data: dataUnw[0])
                }else{
                    debugPrint("Error")
                }
            }else{
                debugPrint("Error")
            }
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoTeamPlayers(completion: Result<TeamPlayersServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            if let dataUnw = data?.response {
                if dataUnw.count > 0 {
                    self.dividePlayersInPositions(data: dataUnw[0].players)
                }else{
                    debugPrint("Error")
                }
            }else{
                debugPrint("Error")
            }
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    
}
