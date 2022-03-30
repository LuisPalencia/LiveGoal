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
protocol DetailPlayerInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataPlayerInteractor()
    func fetchDataPlayerTrophiesInteractor()
    func fetchDataPlayerTransfersInteractor()
}

// Output Provider
protocol DetailPlayerProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoPlayer(completion: Result<DetailPlayerServerModel?, NetworkError>)
    func setInfoPlayerTrophies(completion: Result<PlayerTrophiesServerModel?, NetworkError>)
    func setInfoPlayerTransfers(completion: Result<PlayerTransfersServerModel?, NetworkError>)
}


final class DetailPlayerInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: DetailPlayerInteractorOutputProtocol?{
        super.baseViewModel as? DetailPlayerInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: DetailPlayerProviderInputProtocol?{
        super.baseProvider as? DetailPlayerProviderInputProtocol
    }

    func transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: DetailPlayerServerModel?) -> PlayerDetailStatisticsModelView?{
        if let dataUnw = data?.response{
            if dataUnw.count > 0, let playerUnw = dataUnw[0].player, let statisticsUnw = dataUnw[0].statistics{
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
                                                                 cards: statisticsUnw[0].cards,
                                                                 passes: statisticsUnw[0].passes,
                                                                 dribbles: statisticsUnw[0].dribbles,
                                                                 penalty: statisticsUnw[0].penalty)
                    return model
                }
            }
        }
        
        return nil
    }
    
}

// Input del Interactor
extension DetailPlayerInteractor: DetailPlayerInteractorInputProtocol {
    
    func fetchDataPlayerInteractor() {
        self.provider?.fetchDataPlayerProvider()
    }
    
    func fetchDataPlayerTrophiesInteractor() {
        self.provider?.fetchDataPlayerTrophiesProvider()
    }
    
    func fetchDataPlayerTransfersInteractor() {
        self.provider?.fetchDataPlayerTranfersProvider()
    }
}

// Output Provider
extension DetailPlayerInteractor: DetailPlayerProviderOutputProtocol{
    
    func setInfoPlayer(completion: Result<DetailPlayerServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationPlayer(data: self.transformDataDetailPlayerToPlayerDetailStatisticsModelView(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoPlayerTrophies(completion: Result<PlayerTrophiesServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationPlayerTrophies(data: data?.response)
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoPlayerTransfers(completion: Result<PlayerTransfersServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            if data?.response?.count ?? 0 > 0 {
                self.viewModel?.setInformationPlayerTransfers(data: data?.response?[0].transfers)
            }
            
        case .failure(let error):
            debugPrint(error)
        }
    }
}
