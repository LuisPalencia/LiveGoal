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

struct DetailTeamView: View {
    @StateObject var viewModel = DetailTeamViewModel()
    //var viewModel: ResponseTeamInfo = TeamInfoServerModel.stubbedTeamInfo
    //@SwiftUI.Environment(\.presentationMode) var presenterMode
    
    var body: some View {
        ScrollView{
            VStack{
                //TeamInfoView(viewModel: self.viewModel.dataTeamInfo, currentSeason: self.viewModel.getCurrentSeason())
                //MatchesList(matches: self.viewModel.dataTeamMatches ?? [])
                //TeamPlayersView(players: self.viewModel.dataTeamPlayers ?? [])
                headerView
                teamInfo
                
                if !self.viewModel.dataTeamPlayersGoalkeppers.isEmpty{
                    PlayersCarrousel(title: "Goalkeepers", players: self.viewModel.dataTeamPlayersGoalkeppers, idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason())
                }
                
                if !self.viewModel.dataTeamPlayersDefenders.isEmpty{
                    PlayersCarrousel(title: "Defenders", players: self.viewModel.dataTeamPlayersDefenders, idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason())
                }
                
                if !self.viewModel.dataTeamPlayersMidfielders.isEmpty{
                    PlayersCarrousel(title: "Midfielders", players: self.viewModel.dataTeamPlayersMidfielders, idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason())
                }
                
                if !self.viewModel.dataTeamPlayersAttackers.isEmpty{
                    PlayersCarrousel(title: "Attackers", players: self.viewModel.dataTeamPlayersAttackers, idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason())
                }
                
                if !self.viewModel.dataTeamPlayersUnknown.isEmpty{
                    PlayersCarrousel(title: "Unknown position", players: self.viewModel.dataTeamPlayersUnknown, idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason())
                }
            }
        }
        .padding(.bottom, 80)
        //.padding(.top, 50)
        //.navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.viewModel.fetchData()
            self.viewModel.fetchDataTeamPlayers()
            //self.viewModel.fetchDataTeamMatches()
        }
    }
    
    var headerView: some View{
        ZStack(alignment: .center, content: {
            if self.viewModel.dataTeamInfo?.venue?.imageUrl != nil {
                StadiumImage(imageStadiumUrl: (self.viewModel.dataTeamInfo?.venue?.imageUrl)!)
            }
            
            
            VStack(alignment: .center, content: {
                if self.viewModel.dataTeamInfo?.team?.logoUrl != nil {
                    TeamImage(imageTeamUrl: (self.viewModel.dataTeamInfo?.team!.logoUrl)!)
                }
                
                Text(self.viewModel.dataTeamInfo?.team?.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            })
            //.padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
            
            
            HStack{
//                Button(action: {
//                    self.presenterMode.wrappedValue.dismiss()
//                }, label: {
//                    Image(systemName: "chevron.left")
//                })
//                .padding()
//                .background(Color.white.opacity(0.7))
//                .clipShape(Circle())
//                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                Spacer()
                
                Spacer()
                
                Button(action: {
                    // Aqui salvaremos las peliculas como favoritas en una BBDD (1. Firebase | 2. UserDefault)
                    self.viewModel.saveTeamAsFavourite()
                }, label: {
                    Image(systemName: self.viewModel.isTeamFavourite ? "heart.fill" : "heart")
                })
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
                .padding(EdgeInsets(top: 180, leading: 0, bottom: 0, trailing: 20))
            }
            .foregroundColor(Color.red)
            
        })
    }
    
    var teamInfo: some View {
        
        VStack(alignment: .center, spacing: 10, content: {
            
            HStack(alignment: .center, spacing: 40, content: {
                
                NavigationLink(
                    destination: TeamMatchesCoordinator.view(dto: TeamMatchesCoordinatorDTO(idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason(), idLeague: Constants.laLigaId)),
                    label: {
                        Text("Season matches")
                            .buttonStyleH1()
                    })
                    .buttonStyle(PlainButtonStyle())
                
                
                //Spacer()
                
                NavigationLink(
                    destination: TeamStatisticsCoordinator.view(dto: TeamStatisticsCoordinatorDTO(idTeam: self.viewModel.dataTeamInfo?.team?.id ?? 0, season: self.viewModel.getCurrentSeason(), idLeague: Constants.laLigaId)),
                    label: {
                        Text("Stadistics")
                            .buttonStyleH1()
                    })
                    .buttonStyle(PlainButtonStyle())
            })
            .padding(.bottom, 20)
            
            
            Text("Club information")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            
            
            if self.viewModel.dataTeamInfo?.team?.founded != nil {
                Text("Founded in")
                    .font(.callout)
                Text("\(self.viewModel.dataTeamInfo?.team?.founded ?? 0)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            if self.viewModel.dataTeamInfo?.venue?.city != nil {
                Text("City")
                    .font(.callout)
                Text("\(self.viewModel.dataTeamInfo?.venue?.city ?? "") (\(self.viewModel.dataTeamInfo?.team?.country ?? ""))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            if self.viewModel.dataTeamInfo?.venue?.name != nil {
                Text("Stadium name")
                    .font(.callout)
                Text(self.viewModel.dataTeamInfo?.venue?.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }

            if self.viewModel.dataTeamInfo?.venue?.capacity != nil {
                Text("Capacity")
                    .font(.callout)
                Text("\(self.viewModel.dataTeamInfo?.venue?.capacity ?? 0)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            if self.viewModel.dataTeamInfo?.venue?.address != nil {
                Text("Address")
                    .font(.callout)
                Text(self.viewModel.dataTeamInfo?.venue?.address ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            
            
        })
        .padding(.top, 20)
    }
    
}

struct StadiumImage: View {
    
    let imageStadiumUrl: URL
    @StateObject private var imageLoaderVM = ImageLoader()
    
    var body: some View {
        ZStack{
//            Rectangle()
//                .fill(Color.gray.opacity(0.3))
//                .cornerRadius(8)
//                .shadow(radius: 10)
            
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .grayscale(0.9995)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom))
            }
        }
        .onAppear{
            self.imageLoaderVM.loadImage(whit: imageStadiumUrl)
        }
    }
}

struct TeamImage: View {
    
    let imageTeamUrl: URL
    @StateObject private var imageLoaderVM = ImageLoader()
    
    var body: some View {
        ZStack{
            
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
        .onAppear{
            self.imageLoaderVM.loadImage(whit: imageTeamUrl)
        }
    }
}

struct TeamPlayersView: View {
    var players: [Player]
    @SwiftUI.Environment(\.presentationMode) var presenterMode

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 10, content: {
                ForEach(self.players) { player in
                    NavigationLink(
                        destination: Text(player.name ?? "Error"),
                        label: {
                            PlayerListItem(model: player)
                        })
                        .buttonStyle(PlainButtonStyle())
                    
                }
            })
        })
    }
}


struct DetailTeamView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTeamView()
    }
}

