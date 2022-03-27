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

struct DetailPlayerView: View {

    //@StateObject var viewModel = DetailPlayerViewModel()
    var viewModel: PlayerDetail = DetailPlayerServerModel.stubbedPlayer
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    headerView
                    infoPlayer
                }
            }
        }
        
        //.padding(.horizontal, 8)
        .onAppear {
            //self.viewModel.fetchData()
        }
    }
    
    
    var headerView: some View{
        ZStack(alignment: .topLeading, content: {
            if self.viewModel.player?.photoUrl != nil {
                PlayerImage(playerImageUrl: self.viewModel.player!.photoUrl)
            }
        })
    }
    
    var infoPlayer: some View {
        VStack(spacing: 20, content: {
            VStack(alignment: .center, content: {
                if self.viewModel.statistics?[0].team?.logoUrl != nil {
                    TeamPlayerImage(teamImageUrl: (self.viewModel.statistics?[0].team!.logoUrl)!)
                }
            })
            
            VStack(spacing: 20, content: {
                HStack{
                    Text("\(self.viewModel.player?.firstname ?? "") \(self.viewModel.player?.lastname ?? "")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Age: \(self.viewModel.player?.age ?? 0)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Date of birth: \(self.viewModel.player?.birth?.date ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Nationality: \(self.viewModel.player?.nationality ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                
                
                HStack{
                    Text("Height: \(self.viewModel.player?.height ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Weight: \(self.viewModel.player?.weight ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                if self.viewModel.player?.injured ?? false == true {
                    HStack{
                        Text("Currently injured")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .lineLimit(1)
                        Spacer()
                    }
                }
            })
            
            VStack(spacing: 20, content: {
                Text("Season statistics")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                
                
                HStack{
                    Text("Position: \(self.viewModel.statistics?[0].games?.position ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Matches: \(self.viewModel.statistics?[0].games?.appearences ?? 0)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Headline: \(self.viewModel.statistics?[0].games?.lineups ?? 0)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Minutes: \(self.viewModel.statistics?[0].games?.minutes ?? 0)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                
                HStack{
                    Text("Rating: \(Utils.roundStringDouble(number: self.viewModel.statistics?[0].games?.rating ?? "2.0")) / 10 ★")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                if let positionUnw = self.viewModel.statistics?[0].games?.position {
                    if positionUnw != PlayerPosition.Goalkeeper.rawValue {
                        // Defender, midfielder or attacker
                        HStack{
                            Text("Goals: \(self.viewModel.statistics?[0].goals?.total ?? 0)")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack{
                            Text("Assists: \(self.viewModel.statistics?[0].goals?.assists ?? 0)")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack{
                            Text("Passes completed: \(self.viewModel.statistics?[0].passes?.accuracy ?? 0)%")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack{
                            Text("Dribles: \(self.viewModel.statistics?[0].dribbles?.success ?? 0) / \(self.viewModel.statistics?[0].dribbles?.attempts ?? 0)")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                    }else{
                        // Goalkeeper
                        HStack{
                            Text("Saves: \(self.viewModel.statistics?[0].goals?.saves ?? 0)")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack{
                            Text("Goals conceded: \(self.viewModel.statistics?[0].goals?.conceded ?? 0)")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack{
                            Text("Penalties saved: \(self.viewModel.statistics?[0].penalty?.saved ?? 0)")
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
                
                HStack{
                    Text("Yellow cards: \(self.viewModel.statistics?[0].cards?.yellow ?? 0)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Text("Red cards: \( self.getTotalReds(yellowRed: self.viewModel.statistics?[0].cards?.yellowred ?? 0, red: self.viewModel.statistics?[0].cards?.red ?? 0))")
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
            })
            
            
            
            
        })
        .padding()
        .padding(.bottom, 100)
        .background(
            roundedShape()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -50)
        
        )
        .padding(.top, -50)

        
    }
    
    func getTotalReds(yellowRed: Int, red: Int) -> Int {
        return yellowRed + red
    }
 
}

struct TeamPlayerImage: View {
    let teamImageUrl: URL
    @StateObject private var imageLoaderVM = ImageLoader()
    
    var body: some View {
        ZStack{
            
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .clipShape(Circle())
                    //.overlay(Circle().stroke(Color.black, lineWidth: 2))

            }
        }
        .onAppear{
            self.imageLoaderVM.loadImage(whit: teamImageUrl)
        }
    }
}

struct PlayerImage: View {
    
    let playerImageUrl: URL
    @StateObject private var imageLoaderVM = ImageLoader()
    
    var body: some View {
        ZStack{
            
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    //.padding()

            }
        }
        .onAppear{
            self.imageLoaderVM.loadImage(whit: playerImageUrl)
        }
    }
}

struct roundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}

struct DetailPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlayerView()
    }
}
