//
//  PlayersCarrousel.swift
//  FootballApp
//
//  Created by CICE on 17/03/2022.
//

import SwiftUI

struct PlayersCarrousel: View {
    var title: String
    var players: [Player]
    var idTeam: Int
    var season: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            HStack{
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 50, height: 5)
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 20, content: {
                    ForEach(self.players){ player in
                        NavigationLink(
                            destination: DetailPlayerCoordinator.view(dto: DetailPlayerCoordinatorDTO(idPlayer: player.id ?? 0,
                                                                                                      idTeam: idTeam,
                                                                                                      season: season,
                                                                                                      idLeague: Constants.laLigaId)),
                            label: {
                                PlayerCell(model: player)
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                })
            }
            //.padding([.leading, .trailing], 10)
        })
        
        
        
    }
}



struct PlayerCell: View {
    
    var model: Player = TeamPlayersServerModel.stubbedTeamPlayer
    @ObservedObject var imageLoaderVM = ImageLoader()
    private var colorPosition: Color = Color.green.opacity(0.0)
    private var playerPosition: PlayerPosition = PlayerPosition.Unknown
    
    init(model: Player){
        self.model = model
        self.imageLoaderVM.loadImage(whit: (model.photoUrl))
        
        if let positionUnw = self.model.position {
            switch positionUnw {
            case PlayerPosition.Goalkeeper.rawValue:
                playerPosition = .Goalkeeper
                colorPosition = Color.blue
            case PlayerPosition.Defender.rawValue:
                playerPosition = .Defender
                colorPosition = Color.yellow
            case PlayerPosition.Midfielder.rawValue:
                playerPosition = .Midfielder
                colorPosition = Color.green
            case PlayerPosition.Attacker.rawValue:
                playerPosition = .Attacker
                colorPosition = Color.red
            default:
                playerPosition = .Unknown
                colorPosition = Color.green.opacity(0.0)
            }
        }
    }
    
    var body: some View{
        VStack(spacing: 0, content: {
            ZStack {
                if self.imageLoaderVM.image != nil{
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 130)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(colorPosition, lineWidth: 2))
                        .loader(state: .ok)
                } else{
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 130, height: 130)
                        .cornerRadius(8)
                        .loader(state: .loading)
                }
            }
            .frame(width: 120, height: 150)
            
            Text(self.model.name ?? "")
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(width: 150)
                //.fixedSize(horizontal: true, vertical: false)
                
        })
        .padding([.leading, .trailing], 10)
        .frame(minWidth: 150, maxWidth: 150)
    }
}

struct PlayersCarrousel_Previews: PreviewProvider {
    static var previews: some View {
        PlayersCarrousel(title: "Defensas", players: TeamPlayersServerModel.stubbedTeamPlayers[0].players ?? [], idTeam: 0, season: 0)
    }
}
