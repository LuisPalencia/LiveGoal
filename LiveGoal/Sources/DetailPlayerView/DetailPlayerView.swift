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

    var viewModel: PlayerDetail = DetailPlayerServerModel.stubbedPlayer
    var trophies: [PlayerTrophie] = PlayerTrophiesServerModel.stubbedPlayerTrophiesList
    
    //@StateObject var viewModel = DetailPlayerViewModel()
    @State private var optionSelected = "Information"
    var optionsMenu = ["Information", "Trophies"]
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    headerView
                    bodyView
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
    
    var bodyView: some View {
        VStack(spacing: 10, content: {
            VStack(alignment: .center, content: {
                if self.viewModel.statistics?[0].team?.logoUrl != nil {
                    TeamPlayerImage(teamImageUrl: (self.viewModel.statistics?[0].team!.logoUrl)!)
                }
            })
            .padding(.top, 20)
            
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
                                    .fill(self.optionSelected == item ? Color.blue : Color.black)
                                    .frame(height: 3)
                            }
                            
                        })
                        .foregroundColor(self.optionSelected == item ? .blue : .black)
                        .cornerRadius(10)
                    })
                    .padding([.leading, .trailing], -8)
                }
            }
            .padding([.leading, .trailing], 15)
            
            if optionSelected == "Information"{
                infoPlayer
            }else {
                trophiesView
            }
        })
        //.padding()
        .padding(.bottom, 50)
        .background(
            roundedShape()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -50)
        
        )
        .padding(.top, -50)
    }
    
    var infoPlayer: some View {
        VStack(spacing: 20, content: {
            VStack(spacing: 20, content: {
                HStack{
                    Text("\(self.viewModel.player?.firstname ?? "") \(self.viewModel.player?.lastname ?? "")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image("age")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Age: \(self.viewModel.player?.age ?? 0) years")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Date of birth: \(self.viewModel.player?.birth?.date ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image(systemName: "flag.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Nationality: \(self.viewModel.player?.nationality ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                
                
                HStack(spacing: 10){
                    Image("height")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Height: \(self.viewModel.player?.height ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image("weight")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Weight: \(self.viewModel.player?.weight ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                if self.viewModel.player?.injured ?? false == true {
                    HStack(spacing: 10){
                        Text("Currently injured")
                            .font(.callout)
                            .fontWeight(.semibold)
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
                
                
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Position: \(self.viewModel.statistics?[0].games?.position ?? "Unknown")")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Matches: \(self.viewModel.statistics?[0].games?.appearences ?? 0)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Headline: \(self.viewModel.statistics?[0].games?.lineups ?? 0)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Minutes: \(self.viewModel.statistics?[0].games?.minutes ?? 0)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                    Text("Rating: \(Utils.roundStringDouble(number: self.viewModel.statistics?[0].games?.rating ?? "2.0")) / 10 ★")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
                if let positionUnw = self.viewModel.statistics?[0].games?.position {
                    if positionUnw != PlayerPosition.Goalkeeper.rawValue {
                        // Defender, midfielder or attacker
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Goals: \(self.viewModel.statistics?[0].goals?.total ?? 0)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Assists: \(self.viewModel.statistics?[0].goals?.assists ?? 0)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Passes completed: \(self.viewModel.statistics?[0].passes?.accuracy ?? 0)%")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Dribles: \(self.viewModel.statistics?[0].dribbles?.success ?? 0) / \(self.viewModel.statistics?[0].dribbles?.attempts ?? 0)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                    }else{
                        // Goalkeeper
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Saves: \(self.viewModel.statistics?[0].goals?.saves ?? 0)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Goals conceded: \(self.viewModel.statistics?[0].goals?.conceded ?? 0)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                            Text("Penalties saved: \(self.viewModel.statistics?[0].penalty?.saved ?? 0)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.yellow)
                    Text("Yellow cards: \(self.viewModel.statistics?[0].cards?.yellow ?? 0)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                
//                Rectangle()
//                    .foregroundColor(.black)
//                    .frame(
//                          minWidth: 0,
//                          maxWidth: .infinity,
//                          minHeight: 1,
//                          maxHeight: 1,
//                          alignment: .topLeading
//                        )
//
                
                HStack(spacing: 10){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.red)
                    Text("Red cards: \( self.getTotalReds(yellowRed: self.viewModel.statistics?[0].cards?.yellowred ?? 0, red: self.viewModel.statistics?[0].cards?.red ?? 0))")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
            })
            
            
            
            
        })
        .padding()
        

        
    }
    
    var trophiesView: some View {
        VStack(spacing: 0, content: {
            ForEach(self.trophies){ trophie in
               TrophyItem(model: trophie)
            }
        })
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

