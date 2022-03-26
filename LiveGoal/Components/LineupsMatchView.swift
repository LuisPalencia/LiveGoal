//
//  LineupsMatchView.swift
//  FootballApp
//
//  Created by CICE on 24/03/2022.
//

import SwiftUI

struct LineupsMatchView: View {
    var matchLineupHome: MatchLineupTeam = MatchLineupsServerModel.stubbedMatchLineupHomeTeam
    var matchLineupAway: MatchLineupTeam = MatchLineupsServerModel.stubbedMatchLineupAwayTeam
    var season: Int
    
    private var homeTitularPlayersCount = 0
    private var homeSubstitutePlayersCount = 0
    private var awayTitularPlayersCount = 0
    private var awaySubstitutePlayersCount = 0
    
    init(matchLineupHome: MatchLineupTeam, matchLineupAway: MatchLineupTeam, season: Int){
        self.matchLineupHome = matchLineupHome
        self.matchLineupAway = matchLineupAway
        self.season = season
        
        self.homeTitularPlayersCount = matchLineupHome.startXI?.count ?? 0
        self.awayTitularPlayersCount = matchLineupAway.startXI?.count ?? 0
        self.homeSubstitutePlayersCount = matchLineupHome.substitutes?.count ?? 0
        self.awaySubstitutePlayersCount = matchLineupAway.substitutes?.count ?? 0
    }
    
    var body: some View{
        ScrollView{
            VStack(spacing: 20, content: {
                
                Text("Formation")
                    .font(.title3)

                HStack{
                    HStack(spacing: 5, content: {
                        Text(self.matchLineupHome.formation ?? "")
                            .font(.callout)
                            .fontWeight(.bold)
                    })
                    .padding(.leading, 10)
                    
                    Spacer()
                    
                    HStack(spacing: 5, content: {
                        Text(self.matchLineupAway.formation ?? "")
                            .font(.callout)
                            .fontWeight(.bold)
                    })
                    .padding(.trailing, 10)
                }
                
                Text("Starting lineup")
                    .font(.title3)
                
                HStack(alignment: .top, spacing: 0, content: {
                    VStack(spacing: 10, content: {
                        ForEach(0..<self.homeTitularPlayersCount, id: \.self){ item in
                            LineupHomeTeamItem(player: matchLineupHome.startXI?[item])
                                //.background((item % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.1))
                            
//                            NavigationLink(
//                                destination: DetailPlayerCoordinator.view(dto: DetailPlayerCoordinatorDTO(player: matchLineupHome.startXI?[item].player?.id ?? 0,
//                                                                                                          idTeam: matchLineupHome.team?.id ?? 0,
//                                                                                                          season: season,
//                                                                                                          idLeague: Constants.laLigaId)),
//                                label: {
//                                    LineupHomeTeamItem(player: matchLineupHome.startXI?[item])
//                                })
//                                .buttonStyle(PlainButtonStyle())
                            
                        }
                    })
                                        
                    VStack(spacing: 10, content: {
                        ForEach(0..<self.awayTitularPlayersCount, id: \.self){ item in
                            LineupAwayTeamItem(player: matchLineupAway.startXI?[item])
                                //.background((item % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.1))
                        }
                    })
                    
                    
                })
                
                
                
                Text("Substitutes")
                    .font(.title3)
                
                HStack(alignment: .top, spacing: 0, content: {
                    VStack(spacing: 10, content: {
                        ForEach(0..<self.homeSubstitutePlayersCount, id: \.self){ item in
                            LineupHomeTeamItem(player: matchLineupHome.substitutes?[item])
                                //.background((item % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.1))
                        }
                    })
                                        
                    VStack(spacing: 10, content: {
                        ForEach(0..<self.awaySubstitutePlayersCount, id: \.self){ item in
                            LineupAwayTeamItem(player: matchLineupAway.substitutes?[item])
                                //.background((item % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.1))
                        }
                    })
                })
                
                Text("Coaches")
                    .font(.title3)

                HStack{
                    HStack(spacing: 5, content: {
                        Text(self.matchLineupHome.coach?.name ?? "")
                            .font(.callout)
                            .fontWeight(.bold)
                    })
                    .padding(.leading, 10)
                    
                    Spacer()
                    
                    HStack(spacing: 5, content: {
                        Text(self.matchLineupAway.coach?.name ?? "")
                            .font(.callout)
                            .fontWeight(.bold)
                    })
                    .padding(.trailing, 10)
                }
                
            })
        }
        
        
        
        
    }}


struct LineupHomeTeamItem: View {
    
    var player: PlayerMatch? = MatchLineupsServerModel.stubbedMatchLineupHomeTeamPlayer
    
    var body: some View {
        HStack{
            HStack(spacing: 5, content: {
                Rectangle()
                    .foregroundColor(Utils.getPlayerPositionColorShortName(position: self.player?.player?.pos ?? ""))
                    .frame(width: 5, height: 40)
                Text("\(self.player?.player?.number ?? 0)   \(self.player?.player?.name ?? "")")
                    .font(.callout)
                    .fontWeight(.bold)
            })
            .padding(.leading, 4)
            
            Spacer()
        }
    }
}

struct LineupAwayTeamItem: View {
    
    var player: PlayerMatch? = MatchLineupsServerModel.stubbedMatchLineupAwayTeamPlayer
    
    var body: some View {
        HStack{
            Spacer()
            HStack(spacing: 5, content: {
                Text("\(self.player?.player?.name ?? "")   \(self.player?.player?.number ?? 0)")
                    .font(.callout)
                    .fontWeight(.bold)
                Rectangle()
                    .foregroundColor(Utils.getPlayerPositionColorShortName(position: self.player?.player?.pos ?? ""))
                    .frame(width: 5, height: 40)
            })
            .padding(.trailing, 4)
            
        }
    }
}

struct LineupItem: View {
    
    var playerHomeTeam: PlayerMatch? = MatchLineupsServerModel.stubbedMatchLineupHomeTeamPlayer
    var playerAwayTeam: PlayerMatch? = MatchLineupsServerModel.stubbedMatchLineupAwayTeamPlayer
    
    var body: some View {
        HStack{
            HStack(spacing: 5, content: {
                Rectangle()
                    .foregroundColor(Utils.getPlayerPositionColorShortName(position: self.playerHomeTeam?.player?.pos ?? ""))
                    .frame(width: 5, height: 40)
                Text("\(self.playerHomeTeam?.player?.number ?? 0)   \(self.playerHomeTeam?.player?.name ?? "")")
                    .font(.callout)
                    .fontWeight(.bold)
            })
            .padding(.leading, 4)
            
            Spacer()
            
            HStack(spacing: 5, content: {
                Text("\(self.playerAwayTeam?.player?.name ?? "")   \(self.playerAwayTeam?.player?.number ?? 0)")
                    .font(.callout)
                    .fontWeight(.bold)
                Rectangle()
                    .foregroundColor(Utils.getPlayerPositionColorShortName(position: self.playerHomeTeam?.player?.pos ?? ""))
                    .frame(width: 5, height: 40)
            })
            .padding(.trailing, 4)
        }
    }
}

//struct LineupsMatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LineupsMatchView()
//    }
//}
