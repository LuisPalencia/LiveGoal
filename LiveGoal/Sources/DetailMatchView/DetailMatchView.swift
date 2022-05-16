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

struct DetailMatchView: View {

//    let model: Match = TeamMatchesServerModel.stubbedTeamMatch
//    let matchstatistics: MatchStatisticsViewModel = MatchStatisticsViewModel(id: 720979, teamIdHome: 531, shotsOnGoalHome: 8, shotsOffGoalHome: 8, totalShotsHome: 18, blockedShotsHome: 2,shotsInsideBoxHome: 12, shotsOutsideBoxHome: 6, foulsHome: 9, cornersHome: 6, offsidesHome: 4, ballPossessionHome: 47, yellowCardsHome: 4, redCardsHome: nil, goalkeeperSavesHome: 2, totalPassesHome: 344, totalSuccessfulPassesHome: 252, passesSuccessfulPercentageHome: 73, teamIdAway: 548, shotsOnGoalAway: 2, shotsOffGoalAway: 4, totalShotsAway: 9, blockedShotsAway: 2, shotsInsideBoxAway: 5, shotsOutsideBoxAway: 4, foulsAway: 9, cornersAway: 4, offsidesAway: nil, ballPossessionAway: 53, yellowCardsAway: 1, redCardsAway: nil, goalkeeperSavesAway: 4, totalPassesAway: 408, totalSuccessfulPassesAway: 326, passesSuccessfulPercentageAway: 80)
//    let matchLineups = MatchLineupsServerModel.stubbedMatchLineupTeams
//    let matchEvents = MatchEventsServerModel.stubbedMatchEvents
//    private var match = TeamMatchesServerModel.stubbedTeamMatch
    
    @StateObject var viewModel = DetailMatchViewModel()
    @State private var optionSelected = "Statistics"
    var optionsMenu = ["Statistics", "Events", "Lineups"]
    

    var body: some View {
        ScrollView{
            VStack{
                if let matchUnw = self.viewModel.match {
                    HeaderDetailMatch(match: matchUnw)
                }
                
                HStack(spacing: 0){
                    ForEach(optionsMenu, id: \.self){ item in
                        HStack(alignment: .center, spacing: 0, content: {
                            Button(action: {
                                self.optionSelected = item
                            }, label: {
                                VStack{
                                    Text(item)
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
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
                
                if optionSelected == "Statistics"{
                    statistics
                }else if optionSelected == "Events" {
                    events
                } else {
                    lineups
                }
            }
        }
        //.edgesIgnoringSafeArea(.all)
        .onAppear {
            self.viewModel.fetchData()
        }
    }
    
    
    
    var statistics: some View {
        VStack(spacing: 0, content: {
            
            if let matchUnw = self.viewModel.match {
                HeaderTeamsSubsection(match: matchUnw)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 14)
            }
                
            
            if let matchStatisticsUnw = self.viewModel.matchStatistics{
                StatisticsMatchView(matchStatistics: matchStatisticsUnw)
            }
        })
        
    }
    
    var events: some View {
        VStack(spacing: 0, content: {
            
            if let matchUnw = self.viewModel.match {
                HeaderTeamsSubsection(match: matchUnw)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 14)
                //.background(Color.black.opacity(0.1))
            }
            
            if let matchEventsUnw = self.viewModel.matchEvents {
                if matchEventsUnw.count > 0 {
                    EventsMatchView(matchEvents: matchEventsUnw, idHomeTeam: self.viewModel.match?.teams?.home?.id ?? 0, idAwayTeam: self.viewModel.match?.teams?.away?.id ?? 0)
//                    EventsMatchView(matchEvents: matchEventsUnw, idHomeTeam: 548, idAwayTeam: 531)
                }
            }
            
            
        })
    }
    
    var lineups: some View {
        VStack(spacing: 0, content: {
//            Text("Starting lineups")
//                .font(.title3)
//                .fontWeight(.bold)
//                .padding(10)
            
            if let matchUnw = self.viewModel.match {
                HeaderTeamsSubsection(match: matchUnw)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 14)
                //.background(Color.black.opacity(0.1))
            }
            
            if let matchLineupsUnw = self.viewModel.matchLineups {
                if matchLineupsUnw.count == 2 {
                    LineupsMatchView(matchLineupHome: matchLineupsUnw[0], matchLineupAway: matchLineupsUnw[1], season: self.viewModel.match?.season ?? 0)
                    //LineupsMatchView(matchLineupHome: matchTeamsUnw[0], matchLineupAway: matchTeamsUnw[1], season: self.viewModel?.match?.season ?? 0)
                }
            }
            
            
        })
    }
    
}

struct HeaderDetailMatch: View {
    
    var match: MatchViewModel
    @ObservedObject var imageLoaderHomeTeamVM = ImageLoader()
    @ObservedObject var imageLoaderAwayTeamVM = ImageLoader()
    private var colorResult: Color = Color.green.opacity(0.0)
    private var textStatusMatch = ""
    
    init(match: MatchViewModel){
        self.match = match
        self.imageLoaderHomeTeamVM.loadImage(whit: (self.match.teams?.home!.logoUrl)!)
        self.imageLoaderAwayTeamVM.loadImage(whit: (self.match.teams?.away!.logoUrl)!)
        
        if let statusUnw = self.match.status?.short {
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
        ZStack(alignment: .center, content: {
            HStack{
                NavigationLink(
                    destination: DetailTeamCoordinator.view(dto: DetailTeamCoordinatorDTO(idTeam: self.match.teams?.home?.id ?? 0, season: self.match.season ?? 0, idLeague: Constants.laLigaId)),
                    label: {
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
                            
                            Text(self.match.teams?.home?.name ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                        })
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 10)
                    })
                    .buttonStyle(PlainButtonStyle())
                
                
                VStack(alignment: .center, spacing: 12, content: {
                    Text(self.match.leagueName ?? "")
                        .font(.callout)
                    
                    Text(self.textStatusMatch)
                        .font(.headline)
                        .background(Capsule()
                                        .fill(colorResult)
                                        .padding([.leading, .trailing], -12)
                                        .padding([.top, .bottom], -5)
                        )
                    
                    Text("\(self.match.goals?.home ?? 0) : \(self.match.goals?.away ?? 0)")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .lineLimit(1)
                })
                .frame(maxWidth: .infinity)
                
                NavigationLink(
                    destination: DetailTeamCoordinator.view(dto: DetailTeamCoordinatorDTO(idTeam: self.match.teams?.away?.id ?? 0, season: self.match.season ?? 0, idLeague: Constants.laLigaId)),
                    label: {
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
                            
                            Text(self.match.teams?.away?.name ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                        })
                        .frame(maxWidth: .infinity)
                        .padding(.trailing, 10)
                    })
                    .buttonStyle(PlainButtonStyle())
                
                
            }
        })
        .padding([.bottom], 10)
    }
}

struct HeaderTeamsSubsection: View {
    
    var match: MatchViewModel
    @ObservedObject var imageLoaderHomeTeamVM = ImageLoader()
    @ObservedObject var imageLoaderAwayTeamVM = ImageLoader()
    
    init(match: MatchViewModel){
        self.match = match
        self.imageLoaderHomeTeamVM.loadImage(whit: (self.match.teams?.home!.logoUrl)!)
        self.imageLoaderAwayTeamVM.loadImage(whit: (self.match.teams?.away!.logoUrl)!)
    }
    
    var body: some View {
        HStack{
            if self.imageLoaderHomeTeamVM.image != nil {
                Image(uiImage: self.imageLoaderHomeTeamVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                
            }else{
                Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
            }
            
            Text(self.match.teams?.home?.name ?? "")
                .font(.headline)
                //.foregroundColor(.blue)
            
            Spacer()
            
            Text(self.match.teams?.away?.name ?? "")
                .font(.headline)
                //.foregroundColor(.green)
            
            if self.imageLoaderAwayTeamVM.image != nil {
                Image(uiImage: self.imageLoaderAwayTeamVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                
            }else{
                Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct DetailMatchView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMatchView()
    }
}

