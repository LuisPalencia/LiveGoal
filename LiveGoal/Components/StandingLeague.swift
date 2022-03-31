//
//  StandingLeague.swift
//  LiveGoal
//
//  Created by CICE on 30/03/2022.
//

import SwiftUI


struct StandingLeague: View {
    
    let model: [Standing]
    let season: Int
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            HStack{
                
                VStack(spacing: 0, content: {
                    HStack{
                        
                        Text("Team")
                            .font(.headline)
                            //.padding(.leading, 60)
                            
                            
                        
                    }
                    .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 50,
                          maxHeight: 50
                        )
                    
                    //.background(Color.blue.opacity(0.7))
                    Divider()
                    
                    ForEach(self.model){ standing in
                        NavigationLink(
                            destination: DetailTeamCoordinator.view(dto: DetailTeamCoordinatorDTO(idTeam: standing.id, season: self.season, idLeague: Constants.laLigaId)),
                            //destination: Text("\(standing.team?.name ?? "")"),
                            label: {
                                StandingLeagueTeamItem(model: standing)
                            })
                            .buttonStyle(PlainButtonStyle())
                        
                        
                        
                    }
                })
                
                
                Divider()
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    VStack(alignment: .leading, spacing: 0, content: {
                        
                        HStack(alignment: .center, spacing: 0, content: {
                            Text("PTs")
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .frame(width: 35)
                                
                            
                            Text("MP")
                                .lineLimit(1)
                                .frame(width: 35)
                            
                            Text("MW")
                                .lineLimit(1)
                                .frame(width: 35)

                            Text("MD")
                                .lineLimit(1)
                                .frame(width: 35)

                            Text("ML")
                                .lineLimit(1)
                                .frame(width: 35)

                            Text("GF")
                                .lineLimit(1)
                                .frame(width: 35)

                            Text("GA")
                                .lineLimit(1)
                                .frame(width: 35)

                            
                        })
                        .frame(height: 50)
                        //.background(Color.blue.opacity(0.7))
                        
                        Divider()
                        
                        ForEach(self.model){ standing in
                            NavigationLink(
                                destination: DetailTeamCoordinator.view(dto: DetailTeamCoordinatorDTO(idTeam: standing.id, season: self.season, idLeague: Constants.laLigaId)),
                                //destination: Text("\(standing.team?.name ?? "")"),
                                label: {
                                    StandingLeagueTeamInfoItem(model: standing)
                                })
                                .buttonStyle(PlainButtonStyle())
                        }
                    })
                })
            }
            
        })
        
    }
}

struct StandingLeagueTeamItem: View {
    
    let model: Standing
    @ObservedObject var imageLoaderVM = ImageLoader()
    private var color: Color = Color.green.opacity(0.0)
    
    init(model: Standing){
        self.model = model
        self.imageLoaderVM.loadImage(whit: URL(string: self.model.team?.logo ?? "")!)
        if let rankUnw = self.model.rank {
            switch rankUnw {
            case 1...4:
                color = Color.green
            case 5...6:
                color = Color.yellow
            case 18...20:
                color = Color.red
            default:
                color = Color.green.opacity(0.0)
            }
        }
        
    }
    
    var body: some View {
        ZStack {
            HStack{
                Rectangle()
                    .foregroundColor(self.color)
                    .frame(width: 5, height: 50)
                HStack{
                    
                    Text("\(self.model.rank ?? 0).")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(width: 28)
                    
                    if self.imageLoaderVM.image != nil {
                        Image(uiImage: self.imageLoaderVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                        
                    }else{
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                            .clipShape(Circle())
                            .frame(width: 20, height: 20)
                    }
                    
                    Text(self.model.team?.name ?? "")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    
                    
                    
                }
                //.padding(.horizontal)
                .padding([.top, .bottom], 5)
                .frame(width: 200, height: 50)
            }
        }
    }
}

struct StandingLeagueTeamInfoItem: View {
    
    let model: Standing
    
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Text("\(self.model.points ?? 0)")
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(width: 35)
            
            Text("\(self.model.all?.played ?? 0)")
                .lineLimit(1)
                .frame(width: 35)
            
            Text("\(self.model.all?.win ?? 0)")
                .lineLimit(1)
                .frame(width: 35)
            
            Text("\(self.model.all?.draw ?? 0)")
                .lineLimit(1)
                .frame(width: 35)
            
            Text("\(self.model.all?.lose ?? 0)")
                .lineLimit(1)
                .frame(width: 35)
            
            Text("\(self.model.all?.goals?.goalsFor ?? 0)")
                .lineLimit(1)
                .frame(width: 35)
            
            Text("\(self.model.all?.goals?.against ?? 0)")
                .lineLimit(1)
                .frame(width: 35)
            
        })
        .padding([.top, .bottom], 5)
        .frame(height: 50)
    }
    
}

struct StandingLeague_Previews: PreviewProvider {
    static var previews: some View {
        StandingLeague(model: LeagueStandingServerModel.stubbedLeagueStandings, season: 2021)
    }
}
