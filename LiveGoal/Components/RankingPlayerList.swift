//
//  RankingPlayerList.swift
//  LiveGoal
//
//  Created by CICE on 26/03/2022.
//

import SwiftUI

struct RankingPlayerList: View {
    
    //var modelTopPlayers: [RankingPlayer] = RankingPlayersServerModel.stubbedTopPlayers
    var modelTopPlayers:  [PlayerDetailStatisticsModelView]
    var rankingType: RankingTypes = .Goals
    
    
    var body: some View {
        VStack(spacing: 0, content: {
            ForEach(0..<self.modelTopPlayers.count, id: \.self){ item in
                RankingPlayerCell(model: modelTopPlayers[item], position: item + 1, rankingType: rankingType)
                    .background((item % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.05))
            }
        })
        
    }
}

struct RankingPlayerCell: View {
    
    var model: PlayerDetailStatisticsModelView
    var position: Int = 0
    var rankingType: RankingTypes = .Goals
    
    private var valueRanking: Int = 0
    
    @StateObject private var imageLoaderPlayerVM = ImageLoader()
    @StateObject private var imageLoaderTeamVM = ImageLoader()
    
    init(model: PlayerDetailStatisticsModelView, position: Int, rankingType: RankingTypes){
        self.model = model
        self.position = position
        
        switch rankingType {
        case .Goals:
            self.valueRanking = model.goals?.total ?? 0
        case .Assists:
            self.valueRanking = model.goals?.assists ?? 0
        case .YellowCards:
            self.valueRanking = (model.cards?.yellow ?? 0) + (model.cards?.yellowred ?? 0)
        case .RedCards:
            self.valueRanking = model.cards?.red ?? 0
        }
    }
    
    var body: some View{
        HStack{
            Text("\(self.position)")
                .font(.headline)
                //.fontWeight(.bold)
            
            if self.imageLoaderPlayerVM.image != nil {
                Image(uiImage: self.imageLoaderPlayerVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }else{
                Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
            }
            
            Text(self.model.player?.name ?? "")
                .font(.headline)
                .lineLimit(1)
            Spacer()
            
            if self.imageLoaderTeamVM.image != nil {
                Image(uiImage: self.imageLoaderTeamVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)
            }else{
                Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)
            }
            
            Text("\(self.valueRanking)")
                .font(.headline)
                .fontWeight(.bold)
                .frame(width: 25, height: 20, alignment: .trailing)
            
            
        }
        //.padding([.leading, .trailing], 15)
        //.padding([.top, .bottom], 15)
        .padding(15)
        .onAppear{
            self.imageLoaderPlayerVM.loadImage(whit: model.player!.photoUrl)
            self.imageLoaderTeamVM.loadImage(whit: model.logoTeamUrl!)
        }
    }
    
    
}

//struct RankingPlayerList_Previews: PreviewProvider {
//    static var previews: some View {
//        RankingPlayerList()
//    }
//}
