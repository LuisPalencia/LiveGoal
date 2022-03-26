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
protocol DetailPlayerProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataPlayerProvider()
    func fetchDataPlayerTrophiesProvider()
}

final class DetailPlayerProvider: BaseProvider{
    
    // MARK: - DI
    weak var interactor: DetailPlayerProviderOutputProtocol?{
        super.baseInteractor as? DetailPlayerProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    var dataDTO: DetailPlayerCoordinatorDTO?
    
}

extension DetailPlayerProvider: DetailPlayerProviderInputProtocol{
    func fetchDataPlayerProvider() {
        self.networkService.requestGeneric(payloadRequest: DetailPlayerRequestDTO.requestData(idPlayer: String(dataDTO?.idPlayer ?? 0), idTeam: String(dataDTO?.idTeam ?? 0), season: String(dataDTO?.season ?? 0), idLeague: dataDTO?.idLeague ?? ""), entityClass: DetailPlayerServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoPlayer(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoPlayer(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataPlayerTrophiesProvider() {
        self.networkService.requestGeneric(payloadRequest: DetailPlayerRequestDTO.requestDataPlayerTrophies(idPlayer: String(dataDTO?.idPlayer ?? 0)), entityClass: PlayerTrophiesServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoPlayerTrophies(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoPlayerTrophies(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
}

// MARK: - Request de apoyo
struct DetailPlayerRequestDTO {
    
    static func requestData(idPlayer: String, idTeam: String, season: String, idLeague: String) -> RequestDTO {
        let argument: [CVarArg] = [idPlayer, idTeam, season, idLeague]
        let urlComplete = String(format: URLEnpoint.endpointPlayerStatistics, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
    static func requestDataPlayerTrophies(idPlayer: String) -> RequestDTO {
        let argument: [CVarArg] = [idPlayer]
        let urlComplete = String(format: URLEnpoint.endpointPlayerTrophies, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
}
