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

struct LeagueClassificationView: View {

    @StateObject var viewModel = LeagueClassificationViewModel()
    //var viewModel: CurrentSeasonLeagueModelView

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            Section(header: VStack(alignment: .leading, spacing: 0, content: {
                Text("Standing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom, 6)
                
                HStack{
                    Text("Team")
                        .font(.headline)
                        .padding(.leading, 60)
                    
                    Spacer()
                    
                    Text(self.getHeaderTeamInfo())
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 14, weight: .bold))
                        //.font(.headline)
                        .padding(.trailing, 6)
                        
                }
                //.padding(.horizontal)
                .background(Color.blue.opacity(0.7))
            })) {
                VStack(spacing: 0) {
                    ForEach(self.viewModel.standing ?? []){ standing in
                        
                        NavigationLink(
                            destination: DetailTeamCoordinator.view(dto: DetailTeamCoordinatorDTO(idTeam: standing.id, season: self.viewModel.dataCurrentSeasonLeague?.year ?? 0, idLeague: Constants.laLigaId)),
                            //destination: Text("\(standing.team?.name ?? "")"),
                            label: {
                                StandingTeamItem(model: standing)
                                    .padding(.bottom, 0)
                                    .background((standing.rank! % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.1))
                            })
                            .buttonStyle(PlainButtonStyle())
                        
                    }
                }
            }
            .padding(.bottom, 20)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                self.viewModel.fetchData()
            }
        }
        
        
        
        
        /*
        ScrollView{
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Standing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack{
                    Text("Team")
                        .font(.headline)
                        .padding(.leading, 60)
                    
                    Spacer()
                    
                    Text(self.getHeaderTeamInfo())
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16, weight: .bold))
                        .layoutPriority(1)
                        
                }
                .background(Color.blue.opacity(0.7))
                
                ScrollView{
                    ForEach(self.viewModel.standing ?? []){ standing in
                        StandingTeamItemV2(model: standing)
                            .padding(.bottom, 0)
                            .background((standing.rank! % 2) == 1 ? Color.white.opacity(1) : Color.black.opacity(0.2))
                    }
                }
                
            })
        }.padding(0)
 */
        
        /*
        VStack(alignment: .leading, spacing: 5, content: {
            Text("Standing")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
            

            
            ScrollView{
                HStack(alignment: .top, spacing: 0, content: {
                    VStack{
                        ForEach(self.viewModel.standing ?? []){ standing in
                            StandingTeamItem(model: standing)
                                .padding(0)
                                
                        }
                    }
                    .padding(.bottom, 0)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        VStack(alignment: .leading, content: {
                            ForEach(self.viewModel.standing ?? []){ standing in
                                StandingTeamDataItem(model: standing)
                                    .padding(0)
                                    
                            }
                        })
                    }
                    .padding(.bottom, 0)
                })
        })
        .padding(.bottom, 20)
        .onAppear {
            //self.viewModel.fetchData()
        }
 */
    }
    
    func getHeaderTeamInfo() -> String {
        let fields = ["PT", "MP", "MW", "MD", "ML", "GF", "GA"].map {
            $0.padding(toLength: 4, withPad: " ", startingAt: 0)
        }
        
        return fields.reduce("", +)
    }
 
    
    
}

struct LeagueClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueClassificationView()
//        LeagueClassificationView(viewModel: CurrentSeasonLeagueModelView(id: 140,
//                                                                         name: "La Liga",
//                                                                         type: "League",
//                                                                         logo: "https://media.api-sports.io/football/leagues/140.png",
//                                                                         year: 2021,
//                                                                         start: "2021-08-13",
//                                                                         end: "2022-05-22",
//                                                                         nameCountry: "Spain",
//                                                                         codeCountry: "ES",
//                                                                         flag: "https://media.api-sports.io/flags/es.svg",
//                                                                         standing: LeagueStandingServerModel.stubbedLeagueStandings))
    }
}

