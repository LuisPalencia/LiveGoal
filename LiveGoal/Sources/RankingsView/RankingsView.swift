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

import SwiftUI

struct RankingsView: View {
    
    //var modelTopPlayers: [RankingPlayer] = RankingPlayersServerModel.stubbedTopPlayers
    
    @StateObject var viewModel = RankingsViewModel()
    @State private var optionSelected = "Goals"
    var optionsMenu = ["Goals", "Assists", "Yellow cards", "Red cards"]

    var body: some View {
        VStack(spacing: 0){
            Text("Season top players")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            HStack(spacing: 0){
                ForEach(optionsMenu, id: \.self){ item in
                    HStack(alignment: .center, spacing: 0, content: {
                        Button(action: {
                            self.optionSelected = item
                        }, label: {
                            VStack{
                                Text(item)
                                    .font(Font.system(size: 14, weight: .semibold))
                                    .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    .lineLimit(1)
                                Rectangle()
                                    .fill(self.optionSelected == item ? Color.green : Color.black)
                                    .frame(height: 3)
                            }
                            
                        })
                        .foregroundColor(self.optionSelected == item ? .green : .black)
                        //.background(self.optionSelected == item ? Color.black : Color.clear)
                        .cornerRadius(10)
                    })
                    .padding([.leading, .trailing], -8)
                }
            }
            
            ScrollView{
                VStack(spacing: 0, content: {
                    if optionSelected == "Goals" {
                        if self.viewModel.dataTopPlayerScorers.count > 0 {
                            
                            NavigationLink(
                                destination: DetailPlayerCoordinator.view(
                                    dto: DetailPlayerCoordinatorDTO(
                                        idPlayer: self.viewModel.dataTopPlayerScorers[0].id ?? 0,
                                        idTeam: self.viewModel.dataTopPlayerScorers[0].teamId ?? 0,
                                        season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0,
                                        idLeague: Constants.laLigaId)),
                                label: {
                                    FirstPlayerRankingView(model: self.viewModel.dataTopPlayerScorers[0], valueRanking: self.viewModel.dataTopPlayerScorers[0].goals?.total ?? 0, backgroundColor: Color.blue.opacity(0.7))
                                })
                                .buttonStyle(PlainButtonStyle())
                            
                            RankingPlayerList(modelTopPlayers: self.viewModel.getTopPlayersFromSecond(type: .Goals), rankingType: .Goals, startPosition: 2, season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0)
                        }
                        
                    } else if optionSelected == "Assists" {
                        
                        if self.viewModel.dataTopPlayerAssists.count > 0 {
                            
                            NavigationLink(
                                destination: DetailPlayerCoordinator.view(
                                    dto: DetailPlayerCoordinatorDTO(
                                        idPlayer: self.viewModel.dataTopPlayerAssists[0].id ?? 0,
                                        idTeam: self.viewModel.dataTopPlayerAssists[0].teamId ?? 0,
                                        season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0,
                                        idLeague: Constants.laLigaId)),
                                label: {
                                    FirstPlayerRankingView(model: self.viewModel.dataTopPlayerAssists[0], valueRanking: self.viewModel.dataTopPlayerAssists[0].goals?.assists ?? 0, backgroundColor: Color.orange)
                                })
                                .buttonStyle(PlainButtonStyle())
                            
                            
                            RankingPlayerList(modelTopPlayers: self.viewModel.getTopPlayersFromSecond(type: .Assists), rankingType: .Assists, startPosition: 2, season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0)
                        }
                            
                    } else if optionSelected == "Yellow cards" {
                        
                        if self.viewModel.dataTopPlayerYellowCards.count > 0 {
                            
                            NavigationLink(
                                destination: DetailPlayerCoordinator.view(
                                    dto: DetailPlayerCoordinatorDTO(
                                        idPlayer: self.viewModel.dataTopPlayerYellowCards[0].id ?? 0,
                                        idTeam: self.viewModel.dataTopPlayerYellowCards[0].teamId ?? 0,
                                        season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0,
                                        idLeague: Constants.laLigaId)),
                                label: {
                                    FirstPlayerRankingView(model: self.viewModel.dataTopPlayerYellowCards[0], valueRanking: (self.viewModel.dataTopPlayerYellowCards[0].cards?.yellow ?? 0) + (self.viewModel.dataTopPlayerYellowCards[0].cards?.yellowred ?? 0), backgroundColor: Color.yellow)
                                })
                                .buttonStyle(PlainButtonStyle())
                            
                            
                            RankingPlayerList(modelTopPlayers: self.viewModel.getTopPlayersFromSecond(type: .YellowCards), rankingType: .YellowCards, startPosition: 2, season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0)
                        }
                        
                    } else {
                        if self.viewModel.dataTopPlayerRedCards.count > 0 {
                            
                            NavigationLink(
                                destination: DetailPlayerCoordinator.view(
                                    dto: DetailPlayerCoordinatorDTO(
                                        idPlayer: self.viewModel.dataTopPlayerRedCards[0].id ?? 0,
                                        idTeam: self.viewModel.dataTopPlayerRedCards[0].teamId ?? 0,
                                        season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0,
                                        idLeague: Constants.laLigaId)),
                                label: {
                                    FirstPlayerRankingView(model: self.viewModel.dataTopPlayerRedCards[0], valueRanking: self.viewModel.dataTopPlayerRedCards[0].cards?.red ?? 0, backgroundColor: Color.red)
                                })
                                .buttonStyle(PlainButtonStyle())
                            
                            
                            RankingPlayerList(modelTopPlayers: self.viewModel.getTopPlayersFromSecond(type: .RedCards), rankingType: .RedCards, startPosition: 2, season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0)
                        }
                        
                    }
                })

            }
        }
        .padding(.bottom, 80)
        .padding(.top, 50)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.viewModel.fetchData()
        }
    }
}

struct FirstPlayerRankingView: View {
    
    //var model: RankingPlayer = RankingPlayersServerModel.stubbedTopPlayer
    var model: PlayerDetailStatisticsModelView
    var valueRanking: Int = 0
    @StateObject private var imageLoaderVM = ImageLoader()
    @StateObject private var imageLoaderTeamVM = ImageLoader()
    var backgroundColor: Color = Color.blue.opacity(0.7)
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0, content: {
            Spacer()
            VStack{
                Text("1")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(Circle())
                    //.padding(.top, 40)
                
                if self.imageLoaderTeamVM.image != nil {
                    Image(uiImage: self.imageLoaderTeamVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
            }
            
            Spacer()
            VStack(spacing: 10, content: {
                ZStack(content: {
                    if self.imageLoaderVM.image != nil {
                        Image(uiImage: self.imageLoaderVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                    }
                })
                
                Text(self.model.player?.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
            })
            
            Spacer()
            
            
            Text("\(self.valueRanking)")
                .font(.title)
                .fontWeight(.bold)
                //.padding(5)
                .frame(width: 45, height: 45, alignment: .trailing)
            Spacer()
        })
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 240,
              maxHeight: 240,
              alignment: .center
            )
        .background(backgroundColor)
        .onAppear{
            if let photoUrlUnw = self.model.player?.photoUrl {
                self.imageLoaderVM.loadImage(whit: photoUrlUnw)
            }
            
            if let photoTeamUrlUnw = self.model.logoTeamUrl {
                self.imageLoaderTeamVM.loadImage(whit: photoTeamUrlUnw)
            }
            
        }
    }
}

struct RankingsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingsView()
    }
}

