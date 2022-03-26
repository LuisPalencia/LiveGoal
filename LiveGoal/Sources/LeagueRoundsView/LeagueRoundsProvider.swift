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
protocol LeagueRoundsProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataCurrentSeasonLeagueProvider(idLeague: String)
    func fetchDataLeagueRoundsProvider(idLeague: Int, season: Int)
    func fetchDataLeagueAllMatchesProvider(idLeague: Int, season: Int)
}

final class LeagueRoundsProvider: BaseProvider{
    
    // MARK: - DI
    weak var interactor: LeagueRoundsProviderOutputProtocol?{
        super.baseInteractor as? LeagueRoundsProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
}

extension LeagueRoundsProvider: LeagueRoundsProviderInputProtocol{
    
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
    
    func fetchDataLeagueRoundsProvider(idLeague: Int, season: Int){
        self.networkService.requestGeneric(payloadRequest: LeagueRoundsRequestDTO.requestDataSeasonRounds(season: String(season), idLeague:String(idLeague)), entityClass: SeasonRoundsServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    print(error)
                    self?.interactor?.setInformationLeagueRounds(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInformationLeagueRounds(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataLeagueAllMatchesProvider(idLeague: Int, season: Int){
        self.networkService.requestGeneric(payloadRequest: LeagueRoundsRequestDTO.requestDataMatchesAllSeason(season: String(season), idLeague:String(idLeague)), entityClass: TeamMatchesServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    print(error)
                    self?.interactor?.setInformationLeagueAllMatches(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInformationLeagueAllMatches(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
}

// MARK: - Request de apoyo
struct LeagueRoundsRequestDTO {
    
    static func requestDataSeasonRounds(season: String, idLeague: String) -> RequestDTO {
        let argument: [CVarArg] = [season, idLeague]
        let urlComplete = String(format: URLEnpoint.endpointSeasonRounds, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
    static func requestDataMatchesAllSeason(season: String, idLeague: String) -> RequestDTO {
        let argument: [CVarArg] = [season, idLeague]
        let urlComplete = String(format: URLEnpoint.endpointMatchesAllSeason, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
    

    
}
