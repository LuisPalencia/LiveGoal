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

struct TeamStatisticsView: View {
    
    @StateObject var viewModel = TeamStatisticsViewModel()

    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 0){
                if let teamLogoUrlUnw = self.viewModel.dataTeamStatistics?.team?.logoUrl {
                    HeaderTeamStatistics(teamName: self.viewModel.dataTeamStatistics?.team?.name ?? "", imageStadiumUrl: teamLogoUrlUnw)
                        .padding(20)
                    
                }
                
                matchStatistics
                goalStatistics
                otherStatistics
                
                
                
                
            }
        })
        
        .frame(
              minWidth: 0,
              maxWidth: .infinity
              //minHeight: 0,
              //maxHeight: .infinity,
              //alignment: .center
            )
        .onAppear {
            self.viewModel.fetchData()
        }
    }
    
    var matchStatistics: some View {
        VStack(spacing: 0){
            HStack {
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Last 10 matches:")
                        .font(.title3)
                        .fontWeight(.bold)
                    TextFormTeamView(formTeam: String(self.viewModel.dataTeamStatistics?.form?.suffix(10) ?? ""))
                })
                Spacer()
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.black.opacity(0.1))
            
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Wins:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Home: \(self.viewModel.dataTeamStatistics?.fixtures?.wins?.home ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Total: \(self.viewModel.dataTeamStatistics?.fixtures?.wins?.total ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Away: \(self.viewModel.dataTeamStatistics?.fixtures?.wins?.away ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.viewModel.dataTeamStatistics?.fixtures?.wins?.homePercentageDecimal ?? 0.5).frame(height: 20)
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.white.opacity(1))
            
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Draws:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Home: \(self.viewModel.dataTeamStatistics?.fixtures?.draws?.home ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Total: \(self.viewModel.dataTeamStatistics?.fixtures?.draws?.total ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Away: \(self.viewModel.dataTeamStatistics?.fixtures?.draws?.away ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.viewModel.dataTeamStatistics?.fixtures?.draws?.homePercentageDecimal ?? 0.5).frame(height: 20)
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.black.opacity(0.1))
            
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Loses:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Home: \(self.viewModel.dataTeamStatistics?.fixtures?.loses?.home ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Total: \(self.viewModel.dataTeamStatistics?.fixtures?.loses?.total ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("Away: \(self.viewModel.dataTeamStatistics?.fixtures?.loses?.away ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.viewModel.dataTeamStatistics?.fixtures?.loses?.homePercentageDecimal ?? 0.5).frame(height: 20)
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.white.opacity(1))
        }
    }
    
    var goalStatistics: some View {
        VStack(spacing: 0){
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Goals scored vs received:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Scored: \(self.viewModel.dataTeamStatistics?.goals?.goalsFor?.total?.total ?? 0)")
                            .font(.headline)
                        Spacer()
                        
                        Spacer()
                        Text("Against: \(self.viewModel.dataTeamStatistics?.goals?.against?.total?.total ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: Utils.calculatePercentageDecimal(number1: self.viewModel.dataTeamStatistics?.goals?.goalsFor?.total?.total ?? 0, number2: self.viewModel.dataTeamStatistics?.goals?.against?.total?.total ?? 0)).frame(height: 20)
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.black.opacity(0.1))
            
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Goals scored:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Home: \(self.viewModel.dataTeamStatistics?.goals?.goalsFor?.total?.home ?? 0)")
                            .font(.headline)
                        Spacer()
                        
                        Spacer()
                        Text("Away: \(self.viewModel.dataTeamStatistics?.goals?.goalsFor?.total?.away ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.viewModel.dataTeamStatistics?.goals?.goalsFor?.total?.homePercentageDecimal ?? 0.5).frame(height: 20)
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.white.opacity(1))
            
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Goals received:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Home: \(self.viewModel.dataTeamStatistics?.goals?.against?.total?.home ?? 0)")
                            .font(.headline)
                        Spacer()
                        
                        Spacer()
                        Text("Away: \(self.viewModel.dataTeamStatistics?.goals?.against?.total?.away ?? 0)")
                            .font(.headline)
                        
                    }
                    ProgressBar(value: self.viewModel.dataTeamStatistics?.goals?.against?.total?.homePercentageDecimal ?? 0.5).frame(height: 20)
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.black.opacity(0.1))
        }
    }
    
    var otherStatistics: some View {
        VStack(spacing: 0){
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Spacer()
                    Text("Formations:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 15, content: {
                    ForEach(self.viewModel.dataTeamStatistics?.lineups ?? []){ lineup in
                        Text("\(lineup.formation ?? ""): \(lineup.played ?? 0) matches")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.white)
            
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Spacer()
                    Text("Streaks:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack(spacing: 20, content: {
                    Spacer()
                    Text("Wins: \(self.viewModel.dataTeamStatistics?.biggest?.streak?.wins ?? 0)")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("Draws: \(self.viewModel.dataTeamStatistics?.biggest?.streak?.draws ?? 0)")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Loses: \(self.viewModel.dataTeamStatistics?.biggest?.streak?.loses ?? 0)")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.black.opacity(0.1))
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Spacer()
                    Text("Biggest wins:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack(spacing: 20, content: {
                    Spacer()
                    Text("Home win: \(self.viewModel.dataTeamStatistics?.biggest?.wins?.home ?? "None")")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Text("Away win: \(self.viewModel.dataTeamStatistics?.biggest?.wins?.away ?? "None")")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.white)
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Spacer()
                    Text("Cards")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack(spacing: 20, content: {
                    Image("yellow_card")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    Text("\(self.viewModel.dataTeamStatistics?.cards?.totalYellowCards ?? 0)")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                    
                })
                
                HStack(spacing: 20, content: {
                    Image("red_card")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    Text("\(self.viewModel.dataTeamStatistics?.cards?.totalRedCards ?? 0)")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                    
                })
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .background(Color.black.opacity(0.1))
            
        }

    }
}

//struct TeamStatisticsView: View {
//
//    var viewModel: TeamStatistics = TeamStatisticsServerModel.stubbedTeamStatistics
//
//    //@StateObject var viewModel = TeamStatisticsViewModel()
//
//    var body: some View {
//        ScrollView(showsIndicators: false, content: {
//            VStack(alignment: .center, spacing: 0){
//                if let teamLogoUrlUnw = self.viewModel.team?.logoUrl {
//                    HeaderTeamStatistics(teamName: self.viewModel.team?.name ?? "", imageStadiumUrl: teamLogoUrlUnw)
//                        .padding(20)
//
//                }
//
//                matchStatistics
//                goalStatistics
//                otherStatistics
//
//
//
//
//            }
//        })
//
//        .frame(
//              minWidth: 0,
//              maxWidth: .infinity
//              //minHeight: 0,
//              //maxHeight: .infinity,
//              //alignment: .center
//            )
//        .onAppear {
//            //self.viewModel.fetchData()
//        }
//    }
//
//    var matchStatistics: some View {
//        VStack(spacing: 0){
//            HStack {
//                VStack(alignment: .leading, spacing: 10, content: {
//                    Text("Last 10 matches:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    TextFormTeamView(formTeam: String(self.viewModel.form?.suffix(10) ?? ""))
//                })
//                Spacer()
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.black.opacity(0.1))
//
//            HStack {
//                VStack(alignment: .center, spacing: 10, content: {
//                    Text("Wins:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//
//                    HStack{
//                        Text("Home: \(self.viewModel.fixtures?.wins?.home ?? 0)")
//                            .font(.headline)
//                        Spacer()
//                        Text("Total: \(self.viewModel.fixtures?.wins?.total ?? 0)")
//                            .font(.headline)
//                        Spacer()
//                        Text("Away: \(self.viewModel.fixtures?.wins?.away ?? 0)")
//                            .font(.headline)
//
//                    }
//                    ProgressBar(value: self.viewModel.fixtures?.wins?.homePercentageDecimal ?? 0.5).frame(height: 20)
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.white.opacity(1))
//
//            HStack {
//                VStack(alignment: .center, spacing: 10, content: {
//                    Text("Draws:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//
//                    HStack{
//                        Text("Home: \(self.viewModel.fixtures?.draws?.home ?? 0)")
//                            .font(.headline)
//                        Spacer()
//                        Text("Total: \(self.viewModel.fixtures?.draws?.total ?? 0)")
//                            .font(.headline)
//                        Spacer()
//                        Text("Away: \(self.viewModel.fixtures?.draws?.away ?? 0)")
//                            .font(.headline)
//
//                    }
//                    ProgressBar(value: self.viewModel.fixtures?.draws?.homePercentageDecimal ?? 0.5).frame(height: 20)
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.black.opacity(0.1))
//
//            HStack {
//                VStack(alignment: .center, spacing: 10, content: {
//                    Text("Loses:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//
//                    HStack{
//                        Text("Home: \(self.viewModel.fixtures?.loses?.home ?? 0)")
//                            .font(.headline)
//                        Spacer()
//                        Text("Total: \(self.viewModel.fixtures?.loses?.total ?? 0)")
//                            .font(.headline)
//                        Spacer()
//                        Text("Away: \(self.viewModel.fixtures?.loses?.away ?? 0)")
//                            .font(.headline)
//
//                    }
//                    ProgressBar(value: self.viewModel.fixtures?.loses?.homePercentageDecimal ?? 0.5).frame(height: 20)
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.white.opacity(1))
//        }
//    }
//
//    var goalStatistics: some View {
//        VStack(spacing: 0){
//            HStack {
//                VStack(alignment: .center, spacing: 10, content: {
//                    Text("Goals scored vs received:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//
//                    HStack{
//                        Text("Scored: \(self.viewModel.goals?.goalsFor?.total?.total ?? 0)")
//                            .font(.headline)
//                        Spacer()
//
//                        Spacer()
//                        Text("Against: \(self.viewModel.goals?.against?.total?.total ?? 0)")
//                            .font(.headline)
//
//                    }
//                    ProgressBar(value: Utils.calculatePercentageDecimal(number1: self.viewModel.goals?.goalsFor?.total?.total ?? 0, number2: self.viewModel.goals?.against?.total?.total ?? 0)).frame(height: 20)
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.black.opacity(0.1))
//
//            HStack {
//                VStack(alignment: .center, spacing: 10, content: {
//                    Text("Goals scored:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//
//                    HStack{
//                        Text("Home: \(self.viewModel.goals?.goalsFor?.total?.home ?? 0)")
//                            .font(.headline)
//                        Spacer()
//
//                        Spacer()
//                        Text("Away: \(self.viewModel.goals?.goalsFor?.total?.away ?? 0)")
//                            .font(.headline)
//
//                    }
//                    ProgressBar(value: self.viewModel.goals?.goalsFor?.total?.homePercentageDecimal ?? 0.5).frame(height: 20)
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.white.opacity(1))
//
//            HStack {
//                VStack(alignment: .center, spacing: 10, content: {
//                    Text("Goals received:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//
//                    HStack{
//                        Text("Home: \(self.viewModel.goals?.against?.total?.home ?? 0)")
//                            .font(.headline)
//                        Spacer()
//
//                        Spacer()
//                        Text("Away: \(self.viewModel.goals?.against?.total?.away ?? 0)")
//                            .font(.headline)
//
//                    }
//                    ProgressBar(value: self.viewModel.goals?.against?.total?.homePercentageDecimal ?? 0.5).frame(height: 20)
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.black.opacity(0.1))
//        }
//    }
//
//    var otherStatistics: some View {
//        VStack(spacing: 0){
//
//            VStack(alignment: .leading, spacing: 10){
//                HStack {
//                    Spacer()
//                    Text("Formations:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                VStack(alignment: .leading, spacing: 15, content: {
//                    ForEach(self.viewModel.lineups ?? []){ lineup in
//                        Text("\(lineup.formation ?? ""): \(lineup.played ?? 0) matches")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                    }
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.white)
//
//
//            VStack(alignment: .leading, spacing: 10){
//                HStack {
//                    Spacer()
//                    Text("Streaks:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                HStack(spacing: 20, content: {
//                    Spacer()
//                    Text("Wins: \(self.viewModel.biggest?.streak?.wins ?? 0)")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                    Text("Draws: \(self.viewModel.biggest?.streak?.draws ?? 0)")
//                        .font(.headline)
//                        .fontWeight(.bold)
//
//                    Text("Loses: \(self.viewModel.biggest?.streak?.loses ?? 0)")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                    Spacer()
//
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.black.opacity(0.1))
//
//            VStack(alignment: .leading, spacing: 10){
//                HStack {
//                    Spacer()
//                    Text("Biggest wins:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                HStack(spacing: 20, content: {
//                    Spacer()
//                    Text("Home win: \(self.viewModel.biggest?.wins?.home ?? "None")")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                    Spacer()
//
//                    Text("Away win: \(self.viewModel.biggest?.wins?.away ?? "None")")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                    Spacer()
//
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.white)
//
//            VStack(alignment: .leading, spacing: 10){
//                HStack {
//                    Spacer()
//                    Text("Cards")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                HStack(spacing: 20, content: {
//                    Image("yellow_card")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 18, height: 18)
//                    Text("\(self.viewModel.cards?.totalYellowCards ?? 0)")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                    Spacer()
//
//
//                })
//
//                HStack(spacing: 20, content: {
//                    Image("red_card")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 18, height: 18)
//                    Text("\(self.viewModel.cards?.totalRedCards ?? 0)")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                    Spacer()
//
//
//                })
//            }
//            .padding([.top, .bottom], 15)
//            .padding([.leading, .trailing], 20)
//            .background(Color.black.opacity(0.1))
//
//        }
//
//    }
//}

struct HeaderTeamStatistics: View {
    
    let teamName: String
    let imageStadiumUrl: URL
    @StateObject private var imageLoaderVM = ImageLoader()
    
    var body: some View{
        ZStack(alignment: .center, content: {
            VStack(spacing: 20){
                if self.imageLoaderVM.image != nil {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .frame(width: 100, height: 100, alignment: .center)
                }
                
                Text(self.teamName)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        })
        .onAppear{
            self.imageLoaderVM.loadImage(whit: imageStadiumUrl)
        }
    }
}

struct TextFormTeamView: View {
    
    let formTeam: String
    
    var body: some View {
        HStack(spacing: 5, content: {
            ForEach(Array(self.formTeam), id: \.self) { character in
                TextFormTeamItem(resultMatchTeam: character)
            }
        })
    }
    
}

struct TextFormTeamItem: View {
    
    let resultMatchTeam: Character
    var colorText: Color = Color.black
    
    init(resultMatchTeam: Character){
        self.resultMatchTeam = resultMatchTeam
        
        switch self.resultMatchTeam {
        case "W":
            self.colorText = Color.green
        case "D":
            self.colorText = Color.yellow
        case "L":
            self.colorText = Color.red
        default:
            self.colorText = Color.black
        }
    }
    
    var body: some View {
        Text(String(self.resultMatchTeam))
            .font(.title3)
            .fontWeight(.bold)
            .frame(width: 25, height: 25)
            .padding(1)
            .foregroundColor(.white)
            .background(self.colorText)
            
    }
    
}

struct TeamStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamStatisticsView()
    }
}

