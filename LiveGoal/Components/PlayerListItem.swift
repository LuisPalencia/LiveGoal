//
//  PlayerListItem.swift
//  FootballApp
//
//  Created by CICE on 17/03/2022.
//

import SwiftUI

struct PlayerListItem: View {
    
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
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(spacing: 20, content:{
                Rectangle()
                    .foregroundColor(self.colorPosition)
                    .frame(width: 5, height: 100)
                
                if self.imageLoaderVM.image != nil {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    
                }else{
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                }
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(self.model.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Position: \(self.playerPosition.rawValue)")
                        .font(.callout)
                    Text("Age: \(self.model.age ?? 0)")
                        .font(.callout)
                })
                Spacer()
            })
        })
        
    }
}

struct PlayerListItem_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListItem(model: TeamPlayersServerModel.stubbedTeamPlayer)
    }
}
