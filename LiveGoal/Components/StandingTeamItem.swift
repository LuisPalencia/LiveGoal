//
//  StandingTeamItem.swift
//  FootballApp
//
//  Created by CICE on 13/03/2022.
//

import SwiftUI

struct StandingTeamItem: View {
    
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
                    
                    Text("\(self.model.rank ?? 0)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
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
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(self.getTextTeamData())
                        //.frame(width: 200)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .layoutPriority(1)
                    
                    
                }
                //.padding(.horizontal)
                .padding([.top, .bottom], 5)
                .frame(height: 50)
            }
        }
    }
    
    func getTextTeamData() -> String {
        return ["\(self.model.points ?? 0)", "\(self.model.all?.played ?? 0)", "\(self.model.all?.win ?? 0)", "\(self.model.all?.draw ?? 0)", "\(self.model.all?.lose ?? 0)", "\(self.model.all?.goals?.goalsFor ?? 0)", "\(self.model.all?.goals?.against ?? 0)"].map {
            $0.padding(toLength: 4, withPad: " ", startingAt: 0)
        }.reduce("", +)
    }
}

/*
struct StandingTeamItemOLD: View {
    
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
        ZStack{
            HStack{
                Rectangle()
                    .foregroundColor(self.color)
                    .frame(width: 5, height: 40)
                HStack{
                    
                    Text("\(self.model.rank ?? 0)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    if self.imageLoaderVM.image != nil {
                        Image(uiImage: self.imageLoaderVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .clipShape(Circle())
                        
                    }else{
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                            .clipShape(Circle())
                            .frame(width: 20, height: 20)
                    }
                    
                    Text(self.model.team?.name ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    
                    
                    
                }
                .padding([.top, .bottom, .trailing], 5)
                .frame(height: 40)
            }
        }
        .background((self.model.rank ?? 0 % 2) == 0 ? Color.black.opacity(0.0) : Color.black.opacity(0.2))
        
        
    }
}


struct StandingTeamDataItem: View {
    
    let model: Standing
    
    var body: some View {
        ZStack{
            HStack{
                Text("\(self.model.points ?? 0)")
                    .font(.system(size: 21))
                    .fontWeight(.bold)
                
                Text("\(self.model.all?.played ?? 0)")
                    .font(.system(size: 21))
                
                Text("\(self.model.all?.win ?? 0)")
                    .font(.system(size: 21))
                Text("\(self.model.all?.draw ?? 0)")
                    .font(.system(size: 21))
                Text("\(self.model.all?.lose ?? 0)")
                    .font(.system(size: 21))
                Text("\(self.model.all?.goals?.goalsFor ?? 0)")
                    .font(.system(size: 21))
                Text("\(self.model.all?.goals?.against ?? 0)")
                    .font(.system(size: 21))
                
                
                
                
            }
            .padding(5)
            .frame(height: 40)
        }
        .background((self.model.rank ?? 0 % 2) == 0 ? Color.black.opacity(0.0) : Color.black.opacity(0.1))
        
    }
}
*/
struct StandingTeamItem_Previews: PreviewProvider {
    static var previews: some View {
        StandingTeamItem(model: LeagueStandingServerModel.stubbedLeagueStanding)
    }
}
