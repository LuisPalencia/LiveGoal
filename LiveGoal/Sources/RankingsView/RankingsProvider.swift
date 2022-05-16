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
import Combine

// Input Protocol
protocol RankingsProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataCurrentSeasonLeagueProvider(idLeague: String)
    func fetchDataTopPlayerScorersProvider(season: Int, idLeague: Int)
    func fetchDataTopPlayerAssistsProvider(season: Int, idLeague: Int)
    func fetchDataTopPlayerYellowCardsProvider(season: Int, idLeague: Int)
    func fetchDataTopPlayerRedCardsProvider(season: Int, idLeague: Int)
}

final class RankingsProvider: BaseProvider{
    
    // MARK: - DI
    weak var interactor: RankingsProviderOutputProtocol?{
        super.baseInteractor as? RankingsProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
}

extension RankingsProvider: RankingsProviderInputProtocol{
    
    func fetchDataCurrentSeasonLeagueProvider(idLeague: String) {
        self.networkService.requestGeneric(payloadRequest: LeagueClassificationRequestDTO.requestDataCurrentSeasonLeague(idLeague: idLeague), entityClass: LeagueServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    print(error)
                    self?.interactor?.setInformationCurrentSeasonLeague(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                print(resultData)
                self?.interactor?.setInformationCurrentSeasonLeague(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataTopPlayerScorersProvider(season: Int, idLeague: Int) {
        self.networkService.requestGeneric(payloadRequest: RankingsRequestDTO.requestDataRanking(endpoint: URLEnpoint.endpointTopPlayerScorers, season: String(season), idLeague: String(idLeague)), entityClass: RankingPlayersServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoTopPlayerScorers(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoTopPlayerScorers(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataTopPlayerAssistsProvider(season: Int, idLeague: Int) {
        self.networkService.requestGeneric(payloadRequest: RankingsRequestDTO.requestDataRanking(endpoint: URLEnpoint.endpointTopPlayerAssists, season: String(season), idLeague: String(idLeague)), entityClass: RankingPlayersServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoTopPlayerAssists(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoTopPlayerAssists(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataTopPlayerYellowCardsProvider(season: Int, idLeague: Int) {
        self.networkService.requestGeneric(payloadRequest: RankingsRequestDTO.requestDataRanking(endpoint: URLEnpoint.endpointTopPlayerYellowCards, season: String(season), idLeague: String(idLeague)), entityClass: RankingPlayersServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoTopPlayerYellowCards(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoTopPlayerYellowCards(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataTopPlayerRedCardsProvider(season: Int, idLeague: Int) {
        self.networkService.requestGeneric(payloadRequest: RankingsRequestDTO.requestDataRanking(endpoint: URLEnpoint.endpointTopPlayerRedCards, season: String(season), idLeague: String(idLeague)), entityClass: RankingPlayersServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoTopPlayerRedCards(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoTopPlayerRedCards(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
}

// MARK: - Request de apoyo
struct RankingsRequestDTO {
    
    static func requestDataRanking(endpoint: String, season: String, idLeague: String) -> RequestDTO {
        let argument: [CVarArg] = [season, idLeague]
        let urlComplete = String(format: endpoint, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.getApiKey())
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
}
