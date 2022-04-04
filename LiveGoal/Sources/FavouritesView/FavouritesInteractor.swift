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
protocol FavouritesInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String)
    func fetchDataFromDBInteractor()
}

// Output Provider
protocol FavouritesProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>)
    func setInformationFavouriteTeams(data: [DownloadNewModel])
}


final class FavouritesInteractor: BaseInteractor {
    
    // MARK: - DI
    weak var viewModel: FavouritesInteractorOutputProtocol?{
        super.baseViewModel as? FavouritesInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: FavouritesProviderInputProtocol?{
        super.baseProvider as? FavouritesProviderInputProtocol
    }

    
}

// Input del Interactor
extension FavouritesInteractor: FavouritesInteractorInputProtocol {
    
    func fetchDataCurrentSeasonLeagueInteractor(idLeague: String) {
        self.provider?.fetchDataCurrentSeasonLeagueProvider(idLeague: idLeague)
    }
    
    func fetchDataFromDBInteractor() {
        self.provider?.fetchDataFromDBProvider()
    }
}

// Output Provider
extension FavouritesInteractor: FavouritesProviderOutputProtocol{
    func setInformationCurrentSeasonLeague(completion: Result<LeagueServerModel?, NetworkError>) {
        switch completion {
        case .success(let data):
            self.viewModel?.setInformationCurrentSeasonLeague(data: Utils.transformDataResponseLeagueToCurrentSeasonLeagueModelView(data: data?.response))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInformationFavouriteTeams(data: [DownloadNewModel]) {
        self.viewModel?.setInformationFavouriteTeams(data: data)
    }
}
