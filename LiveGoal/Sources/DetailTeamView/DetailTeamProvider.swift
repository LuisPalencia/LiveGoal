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
protocol DetailTeamProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataTeamInfoProvider()
    func fetchDataTeamPlayersProvider()
    func getCurrentSeason() -> Int
}

final class DetailTeamProvider: BaseProvider{
    
    // MARK: - DI
    weak var interactor: DetailTeamProviderOutputProtocol?{
        super.baseInteractor as? DetailTeamProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    var dataDTO: DetailTeamCoordinatorDTO?
    
}

extension DetailTeamProvider: DetailTeamProviderInputProtocol{
    func getCurrentSeason() -> Int {
        return dataDTO?.season ?? 0
    }
    
    // ->Este metodo nos muestra la forma de suscripcion del metodo al AnyPublisher
    
    func fetchDataTeamInfoProvider(){
        self.networkService.requestGeneric(payloadRequest: DetailTeamRequestDTO.requestDataTeamInfo(idTeam: String(dataDTO?.idTeam ?? 0), season: String(dataDTO?.season ?? 0), idLeague: dataDTO?.idLeague ?? ""), entityClass: TeamInfoServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    print(error)
                    self?.interactor?.setInformationTeam(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                print(resultData)
                self?.interactor?.setInformationTeam(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataTeamPlayersProvider() {
        self.networkService.requestGeneric(payloadRequest: DetailTeamRequestDTO.requestData(endpoint: URLEnpoint.endpointTeamPlayers, idTeam: String(dataDTO?.idTeam ?? 0), season: String(dataDTO?.season ?? 0), idLeague: dataDTO?.idLeague ?? ""), entityClass: TeamPlayersServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInfoTeamPlayers(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInfoTeamPlayers(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
 
    
}

// MARK: - Request de apoyo
struct DetailTeamRequestDTO {
    
    static func requestDataTeamInfo(idTeam: String, season: String, idLeague: String) -> RequestDTO {
        let argument: [CVarArg] = [idTeam, season, idLeague]
        let urlComplete = String(format: URLEnpoint.endpointTeamInformation, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
    static func requestData(endpoint: String, idTeam: String, season: String, idLeague: String) -> RequestDTO {
        let argument: [CVarArg] = [idTeam, season, idLeague]
        let urlComplete = String(format: endpoint, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
    
}
