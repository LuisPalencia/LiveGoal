//
//  MatchResult.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import SwiftUI

struct MatchResult: View {
    
    //let model: Match = TeamMatchesServerModel.stubbedTeamMatch
    let model: MatchViewModel
    @ObservedObject var imageLoaderHomeTeamVM = ImageLoader()
    @ObservedObject var imageLoaderAwayTeamVM = ImageLoader()
    private var colorResult: Color = Color.green.opacity(0.0)
    private var textStatusMatch = ""
    
    init(model: MatchViewModel){
        self.model = model
        self.imageLoaderHomeTeamVM.loadImage(whit: (model.teams?.home!.logoUrl)!)
        self.imageLoaderAwayTeamVM.loadImage(whit: (model.teams?.away!.logoUrl)!)
        
        if let statusUnw = self.model.status?.short {
            switch statusUnw {
            case MatchStatus.time_to_be_defined.rawValue:
                colorResult = Color.blue
                textStatusMatch = "Not defined"
            case MatchStatus.not_started.rawValue:
                colorResult = Color.blue
                textStatusMatch = "Not started"
            case MatchStatus.first_half.rawValue:
                colorResult = Color.green
                textStatusMatch = "First half"
            case MatchStatus.halftime.rawValue:
                colorResult = Color.yellow
                textStatusMatch = "Halftime"
            case MatchStatus.second_half.rawValue:
                colorResult = Color.green
                textStatusMatch = "Second half"
            case MatchStatus.extra_time.rawValue:
                colorResult = Color.green
                textStatusMatch = "Extra time"
            case MatchStatus.finished.rawValue:
                colorResult = Color.red
                textStatusMatch = "Finished"
            default:
                colorResult = Color.green.opacity(0.0)
                textStatusMatch = "¿?"
            }
        }
        
    }
    
    var body: some View {
        VStack(alignment: .center, content: {
            HStack(alignment: .center, content: {
                Text(self.model.dateMatch)
                    .font(.headline)
                    .fontWeight(.bold)
            })
            .padding(14)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.blue.opacity(0.7))
            .foregroundColor(.white)
            
            
            HStack(alignment: .center, spacing: 30, content: {
                VStack(alignment: .center, spacing: 20, content: {
                    if self.imageLoaderHomeTeamVM.image != nil {
                        Image(uiImage: self.imageLoaderHomeTeamVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                        
                    }else{
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                    }
                    
                    Text(self.model.teams?.home?.name ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                })
                .frame(maxWidth: .infinity)
                .padding(.leading, 10)
                
                VStack(alignment: .center, spacing: 20, content: {
                    Text(self.model.leagueName ?? "")
                        .font(.callout)
                    
                    Text(self.textStatusMatch)
                        .font(.headline)
                        .background(Capsule()
                                        .fill(colorResult)
                                        .padding([.leading, .trailing], -12)
                                        .padding([.top, .bottom], -5)
                        )
                    
                    Text("\(self.model.goals?.home ?? 0) : \(self.model.goals?.away ?? 0)")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .lineLimit(1)
                })
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .center, spacing: 20, content: {
                    if self.imageLoaderAwayTeamVM.image != nil {
                        Image(uiImage: self.imageLoaderAwayTeamVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                        
                    }else{
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                    }
                    
                    Text(self.model.teams?.away?.name ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                })
                .frame(maxWidth: .infinity)
                .padding(.trailing, 10)
                
            })
            .padding([.top, .bottom], 10)
        })
        
    }
}

//struct MatchResult_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchResult()
//    }
//}
