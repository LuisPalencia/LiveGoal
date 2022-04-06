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
import AlertToast

// Output del Interactor
protocol DetailTeamInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInformationTeam(data: ResponseTeamInfo?)
    //func setInformationTeamPlayers(data: [Player]?)
    func setInformationTeamPlayersGoalkeepers(data: [Player]?)
    func setInformationTeamPlayersDefenders(data: [Player]?)
    func setInformationTeamPlayersMidfielders(data: [Player]?)
    func setInformationTeamPlayersAttackers(data: [Player]?)
    func setInformationTeamPlayersUnknown(data: [Player]?)
    
}

final class DetailTeamViewModel: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: DetailTeamInteractorInputProtocol?{
        super.baseInteractor as? DetailTeamInteractorInputProtocol
    }
    
    // MARK: - Variables @Published
    @Published var dataTeamInfo: ResponseTeamInfo?
    @Published var dataTeamPlayersGoalkeppers: [Player] = []
    @Published var dataTeamPlayersDefenders: [Player] = []
    @Published var dataTeamPlayersMidfielders: [Player] = []
    @Published var dataTeamPlayersAttackers: [Player] = []
    @Published var dataTeamPlayersUnknown: [Player] = []
    @Published var isTeamFavourite = false
    
    @Published var showToast = false
    @Published var alertToast = AlertToast(type: .regular, title: "")
    
    
    // MARK: - Metodospublicos
    func fetchData(){
        self.interactor?.fetchDataTeamInfoProvider()
    }
    
    func fetchDataTeamPlayers(){
        self.interactor?.fetchDataTeamPlayersProvider()
    }
    
    func getCurrentSeason() -> Int{
        return self.interactor?.getCurrentSeason() ?? 0
    }
    
    func saveTeamAsFavourite(){
        if !self.isTeamFavourite {
            self.interactor?.saveDataAsFavouriteInteractor(name: self.dataTeamInfo?.team?.name ?? "", logo: self.dataTeamInfo?.team?.logo ?? "")
            self.isTeamFavourite = true
            self.alertToast = AlertToast(type: .complete(.green), title: "Success", subTitle: "\(self.dataTeamInfo?.team?.name ?? "") team added to favourites")
            self.showToast.toggle()
        }else{
            self.interactor?.removeDataAsFavouriteInteractor(name: self.dataTeamInfo?.team?.name ?? "", logo: self.dataTeamInfo?.team?.logo ?? "")
            self.isTeamFavourite = false
            self.alertToast = AlertToast(type: .regular, title: "Success", subTitle: "\(self.dataTeamInfo?.team?.name ?? "") team removed from favourites")
            self.showToast.toggle()
        }
        
        
    }
}

// Output del Interactor
extension DetailTeamViewModel: DetailTeamInteractorOutputProtocol {
    
    func setInformationTeam(data: ResponseTeamInfo?) {
        guard let dataUnw = data else {
            return
        }
        self.dataTeamInfo = dataUnw
        DDBB.shared.getAllLocal { result in
            result?.downloads.map{ item in
                item.map{ itemX in
                    if "\(self.dataTeamInfo?.team?.id ?? 0)" == itemX.id {
                        self.isTeamFavourite = true
                    }
                }
            }
        } failure: { error in
            debugPrint(error ?? "")
        }

    }
    
//    func setInformationTeamPlayers(data: [Player]?) {
//        self.dataTeamPlayers = data ?? []
//    }
    
    func setInformationTeamPlayersGoalkeepers(data: [Player]?) {
        self.dataTeamPlayersGoalkeppers = data ?? []
    }
    
    func setInformationTeamPlayersDefenders(data: [Player]?) {
        self.dataTeamPlayersDefenders = data ?? []
    }
    
    func setInformationTeamPlayersMidfielders(data: [Player]?) {
        self.dataTeamPlayersMidfielders = data ?? []
    }
    
    func setInformationTeamPlayersAttackers(data: [Player]?) {
        self.dataTeamPlayersAttackers = data ?? []
    }
    
    func setInformationTeamPlayersUnknown(data: [Player]?) {
        self.dataTeamPlayersUnknown = data ?? []
    }
}


