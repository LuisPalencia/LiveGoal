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
protocol LeagueClassificationInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String)
    func fetchDataLeagueClassificationInteractor(idLeague: Int, season: Int)
}

// Output Provider
protocol LeagueClassificationProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>)
    func setInformationLeagueClassification(completion: Result<LeagueStandingServerModel?, NetworkError>)
}


final class LeagueClassificationInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: LeagueClassificationInteractorOutputProtocol?{
        super.baseViewModel as? LeagueClassificationInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: LeagueClassificationProviderInputProtocol?{
        super.baseProvider as? LeagueClassificationProviderInputProtocol
    }
    
    func transformDataResponseLeagueToCurrentSeasonLeagueModelView(data: [ResponseLeague]?) -> CurrentSeasonLeagueModelView?{
        var currentSeasonLeague: CurrentSeasonLeagueModelView? = nil
        
        if let dataUnw = data{
            guard dataUnw.count > 0 else { return nil }
            if let seasonData = dataUnw[0].seasons, let leagueData = dataUnw[0].league, let countryData = dataUnw[0].country {
                guard seasonData.count > 0 else { return nil }
                currentSeasonLeague = CurrentSeasonLeagueModelView(id: leagueData.id,
                                                                   name: leagueData.name,
                                                                   type: leagueData.type,
                                                                   logo: leagueData.logo,
                                                                   year: seasonData[0].year ,
                                                                   start: seasonData[0].start,
                                                                   end: seasonData[0].end,
                                                                   nameCountry: countryData.name,
                                                                   codeCountry: countryData.code,
                                                                   flag: countryData.flag,
                                                                   standing: nil)
            }else{
                return nil
            }
        }
        
        return currentSeasonLeague
    }
    
    func getStandings(data: ResponseLeagueStanding?) -> [Standing]? {
        if let dataUnw = data {
            if dataUnw.league?.standings?.count ?? 0 > 0 {
                return dataUnw.league?.standings?[0]
            }
        }
        
        return nil
    }

    
}

// Input del Interactor
extension LeagueClassificationInteractor: LeagueClassificationInteractorInputProtocol {
    
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String) {
        self.provider?.fetchDataCurrentSeasonLeagueProvider(idLeague: idLeague)
    }
    
    func fetchDataLeagueClassificationInteractor(idLeague: Int, season: Int) {
        self.provider?.fetchDataLeagueClassificationInteractor(idLeague: idLeague, season: season)
    }
    
}

// Output Provider
extension LeagueClassificationInteractor: LeagueClassificationProviderOutputProtocol{
    
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationCurrentSeasonLeague(data: Utils.transformDataResponseLeagueToCurrentSeasonLeagueModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInformationLeagueClassification(completion: Result<LeagueStandingServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            if let dataUnw = data {
                if dataUnw.response?.count ?? 0 > 0 {
                    self.viewModel?.setInformationLeagueClassification(data: self.getStandings(data: dataUnw.response?[0]))
                }else{
                    debugPrint("Error al obtener los datos")
                }
            }else{
                debugPrint("Error al obtener los datos")
            }
        case .failure(let error):
            debugPrint(error)
        }
    }
    
}
