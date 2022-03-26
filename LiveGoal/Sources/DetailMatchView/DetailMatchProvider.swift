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
protocol DetailMatchProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataMatchStatisticsProvider(idMatch: Int)
    func fetchDataMatchEventsProvider(idMatch: Int)
    func fetchDataMatchLineupsProvider(idMatch: Int)
}

final class DetailMatchProvider: BaseProvider{
    
    // MARK: - DI
    weak var interactor: DetailMatchProviderOutputProtocol?{
        super.baseInteractor as? DetailMatchProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
}

extension DetailMatchProvider: DetailMatchProviderInputProtocol{
    func fetchDataMatchStatisticsProvider(idMatch: Int) {
        self.networkService.requestGeneric(payloadRequest: DetailMatchRequestDTO.requestData(endpoint: URLEnpoint.endpointMatchStatistics,idMatch: String(idMatch)), entityClass: MatchStatisticsServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInformationMatchStatistics(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInformationMatchStatistics(completion: .success(resultData))
            }
            .store(in: &cancellable)

    }
    
    func fetchDataMatchEventsProvider(idMatch: Int) {
        self.networkService.requestGeneric(payloadRequest: DetailMatchRequestDTO.requestData(endpoint: URLEnpoint.endpointMatchEvents,idMatch: String(idMatch)), entityClass: MatchEventsServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInformationMatchEvents(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInformationMatchEvents(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    func fetchDataMatchLineupsProvider(idMatch: Int) {
        self.networkService.requestGeneric(payloadRequest: DetailMatchRequestDTO.requestData(endpoint: URLEnpoint.endpointMatchLineups,idMatch: String(idMatch)), entityClass: MatchLineupsServerModel.self)
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion{
                case .finished:
                    debugPrint("finished")
                case let .failure(error):
                    self?.interactor?.setInformationMatchLineups(completion: .failure(error))
                }
            } receiveValue: { [weak self] resultData in
                guard self != nil else { return }
                self?.interactor?.setInformationMatchLineups(completion: .success(resultData))
            }
            .store(in: &cancellable)
    }
    
    
}

// MARK: - Request de apoyo
struct DetailMatchRequestDTO {
    
    static func requestData(endpoint: String, idMatch: String) -> RequestDTO {
        let argument: [CVarArg] = [idMatch]
        let urlComplete = String(format: endpoint, arguments: argument)
        var headers = URLEnpoint.headersAPI
        headers["x-rapidapi-key"] = Obfuscator().reveal(key: Constants.Api.apiKey)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService, header: headers)
        return request
    }
    
}
