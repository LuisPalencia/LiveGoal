//
//  EventsMatchView.swift
//  FootballApp
//
//  Created by CICE on 24/03/2022.
//

import SwiftUI

struct EventsMatchView: View {
    
    var matchEvents: [MatchEventModel] = MatchEventsServerModel.stubbedMatchEvents
    var idHomeTeam: Int = 531
    var idAwayTeam: Int = 548
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0, content: {
                ForEach(self.matchEvents){ event in
                    EventMatchView(matchEvent: event,
                                   idHomeTeam: idHomeTeam,
                                   idAwayTeam: idAwayTeam)
                }
            })
        }
    }
}

struct EventMatchView: View {
    
    var matchEvent: MatchEventModel = MatchEventsServerModel.stubbedMatchEvent
    var idHomeTeam: Int = 531
    var idAwayTeam: Int = 548
    private var imageEvent = ""
    private var textEvent = ""
    
    init(matchEvent: MatchEventModel, idHomeTeam: Int, idAwayTeam: Int){
        self.matchEvent = matchEvent
        self.idHomeTeam = idHomeTeam
        self.idAwayTeam = idAwayTeam
        
        switch self.matchEvent.type?.lowercased() {
        case "goal":
            self.imageEvent = "ball"
            switch self.matchEvent.detail?.lowercased() {
            case "normal goal":
                if (self.matchEvent.team?.id ?? 0) == idHomeTeam {
                    textEvent = "\(self.matchEvent.player?.name ?? "") (\(self.matchEvent.assist?.name ?? ""))"
                }else{
                    textEvent = "(\(self.matchEvent.assist?.name ?? "")) \(self.matchEvent.player?.name ?? "")"
                }
                
            case "own goal":
                if (self.matchEvent.team?.id ?? 0) == idHomeTeam {
                    textEvent = "\(self.matchEvent.player?.name ?? "") (Own goal)"
                }else{
                    textEvent = "(Own goal) \(self.matchEvent.player?.name ?? "")"
                }
                
            case "penalty":
                if (self.matchEvent.team?.id ?? 0) == idHomeTeam {
                    textEvent = "\(self.matchEvent.player?.name ?? "") (Penalty)"
                }else{
                    textEvent = "(Penalty) \(self.matchEvent.player?.name ?? "")"
                }
                
            case "missed penalty":
                if (self.matchEvent.team?.id ?? 0) == idHomeTeam {
                    textEvent = "\(self.matchEvent.player?.name ?? "") (Missed penalty)"
                }else{
                    textEvent = "(Missed penalty) \(self.matchEvent.player?.name ?? "")"
                }
            default:
                textEvent = ""
                imageEvent = ""
            }
        case "card":
            textEvent = "\(self.matchEvent.player?.name ?? "")"
            
            switch self.matchEvent.detail?.lowercased() {
            case "yellow card":
                self.imageEvent = "yellow_card"
            case "second yellow card":
                self.imageEvent = "yellow_red_card"
            case "red card":
                self.imageEvent = "red_card"
            default:
                self.imageEvent = ""
            }
        case "subst":
            if (self.matchEvent.team?.id ?? 0) == idHomeTeam {
                textEvent = "\(self.matchEvent.assist?.name ?? "") (\(self.matchEvent.player?.name ?? ""))"
            }else{
                textEvent = "(\(self.matchEvent.player?.name ?? "")) \(self.matchEvent.assist?.name ?? "")"
            }
            
            //imageEvent = "repeat.circle"
            imageEvent = "substitution"
        
        case "var":
            if (self.matchEvent.team?.id ?? 0) == idHomeTeam {
                textEvent = "\(self.matchEvent.player?.name ?? "") (\(self.matchEvent.detail ?? ""))"
            }else{
                textEvent = "(\(self.matchEvent.detail ?? "")) \(self.matchEvent.player?.name ?? "")"
            }
            
            imageEvent = "var"
            
        default:
            imageEvent = ""
        }
    }
    
    var body: some View {
        HStack{
            
            if (matchEvent.team?.id ?? 0) == idHomeTeam {
                if let timeExtraUnw = self.matchEvent.time?.extra {
                    Text("\(self.matchEvent.time?.elapsed ?? 0) + \(timeExtraUnw)'")
                        .font(.callout)
                        .fontWeight(.semibold)
                }else{
                    Text("\(self.matchEvent.time?.elapsed ?? 0)'")
                        .font(.callout)
                        .fontWeight(.semibold)
                        
                }
                Image(self.imageEvent)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 18, height: 18)
                
                Text(self.textEvent)
                    .font(.callout)
                    .fontWeight(self.matchEvent.type?.lowercased() == "goal" ? .bold : .regular)
                    
                
            }else{
                Spacer()
            }
            
            Spacer()
            
            if (matchEvent.team?.id ?? 0) == idAwayTeam {
                Text(self.textEvent)
                    .font(.callout)
                    .fontWeight(self.matchEvent.type?.lowercased() == "goal" ? .bold : .regular)
                
                Image(self.imageEvent)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 18, height: 18)
                
                if let timeExtraUnw = self.matchEvent.time?.extra {
                    Text("\(self.matchEvent.time?.elapsed ?? 0) + \(timeExtraUnw)'")
                        .font(.callout)
                        .fontWeight(.semibold)
                }else{
                    Text("\(self.matchEvent.time?.elapsed ?? 0)'")
                        .font(.callout)
                        .fontWeight(.semibold)
                        
                }
                
                
            }else{
                Spacer()
            }
        }
        .padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 15)
    }
}

struct EventsMatchView_Previews: PreviewProvider {
    static var previews: some View {
        EventsMatchView()
    }
}
