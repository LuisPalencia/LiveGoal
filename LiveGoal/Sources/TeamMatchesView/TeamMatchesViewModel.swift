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
protocol TeamMatchesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInformationTeamMatches(data: [MatchViewModel]?)
}

final class TeamMatchesViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: TeamMatchesInteractorInputProtocol?{
        super.baseInteractor as? TeamMatchesInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    @Published var dataTeamMatches: [MatchViewModel]?
    
    // MARK: - Metodospublicos
    func fetchData(){
        self.interactor?.fetchDataTeamMatchesInteractor()
    }
    
}

// Output del Interactor
extension TeamMatchesViewModel: TeamMatchesInteractorOutputProtocol {
    func setInformationTeamMatches(data: [MatchViewModel]?) {
        self.dataTeamMatches = data ?? []
    }
}


