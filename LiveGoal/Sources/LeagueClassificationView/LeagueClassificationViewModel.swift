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

// Output del Interactor
protocol LeagueClassificationInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInformationCurrentSeasonLeague(data: CurrentSeasonLeagueModelView?)
    func setInformationLeagueClassification(data: [Standing]?)
}

final class LeagueClassificationViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: LeagueClassificationInteractorInputProtocol?{
        super.baseInteractor as? LeagueClassificationInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    @Published var dataCurrentSeasonLeague: CurrentSeasonLeagueModelView?
    @Published var standing: [Standing]?
    
    // MARK: - Metodospublicos
    func fetchData(){
        self.interactor?.fetchDataCurrentSeasonLeagueInteractor(idLeague: Constants.laLigaId)
    }
    
}

// Output del Interactor
extension LeagueClassificationViewModel: LeagueClassificationInteractorOutputProtocol {
    
    func setInformationCurrentSeasonLeague(data: CurrentSeasonLeagueModelView?) {
        guard let dataUnw = data else {
            return
        }
        self.dataCurrentSeasonLeague = dataUnw
        self.interactor?.fetchDataLeagueClassificationInteractor(idLeague: dataUnw.id ?? 0, season: dataUnw.year ?? 0)
    }
    
    func setInformationLeagueClassification(data: [Standing]?) {
        self.standing = data ?? []
    }
}


