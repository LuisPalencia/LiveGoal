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
protocol FavouritesProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataCurrentSeasonLeagueProvider(idLeague: String)
    func fetchDataFromDBProvider()
}

final class FavouritesProvider: BaseProvider{
    
    // MARK: - DI
    weak var interactor: FavouritesProviderOutputProtocol?{
        super.baseInteractor as? FavouritesProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
    func getMoviesFromDB(completionHandler: @escaping (DownloadNewModels?) -> ()){
        DDBB.shared.getAllLocal { results in
            completionHandler(results)
        } failure: { error in
            debugPrint(error ?? "")
        }

    }
    
}

extension FavouritesProvider: FavouritesProviderInputProtocol{
    
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
    
    func fetchDataFromDBProvider() {
        var favouriteTeams: [DownloadNewModel] = []
        
        self.getMoviesFromDB { results in
            results?.downloads.map{ item in
                item.map { itemX in
                    print(itemX)
                    favouriteTeams.append(itemX)
                }
                self.interactor?.setInformationFavouriteTeams(data: favouriteTeams)
            }
            
        }
        
    }
    
}

// MARK: - Request de apoyo
struct FavouritesRequestDTO {
    
}
