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
protocol DetailMatchInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInformationMatchStatistics(data: MatchStatisticsViewModel?)
    func setInformationMatchEvents(data: [MatchEventModel]?)
    func setInformationMatchLineups(data: [MatchLineupTeam]?)
}

final class DetailMatchViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: DetailMatchInteractorInputProtocol?{
        super.baseInteractor as? DetailMatchInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    @Published var match: MatchViewModel?
    @Published var matchStatistics: MatchStatisticsViewModel?
    @Published var matchEvents: [MatchEventModel] = []
    @Published var matchLineups: [MatchLineupTeam] = []
    
    // MARK: - Metodospublicos
    
    func fetchData(){
        if let idUnw = self.match?.id{
            self.interactor?.fetchDataMatchStatisticsInteractor(idMatch: idUnw)
            self.interactor?.fetchDataMatchEventsInteractor(idMatch: idUnw)
            self.interactor?.fetchDataMatchLineupsInteractor(idMatch: idUnw)
        }
    }
    
}

// Output del Interactor
extension DetailMatchViewModel: DetailMatchInteractorOutputProtocol {
    func setInformationMatchStatistics(data: MatchStatisticsViewModel?) {
        guard let dataUnw = data else {
            return
        }
        self.matchStatistics = dataUnw
    }
    
    func setInformationMatchEvents(data: [MatchEventModel]?) {
        self.matchEvents = data ?? []
    }
    
    func setInformationMatchLineups(data: [MatchLineupTeam]?) {
        self.matchLineups = data ?? []
    }
    
    
}


