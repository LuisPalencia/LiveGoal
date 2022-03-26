//
//  TestView.swift
//  FootballApp
//
//  Created by CICE on 21/03/2022.
//

import SwiftUI

struct TestView: View {
    
    var viewModel: ResponseTeamInfo = TeamInfoServerModel.stubbedTeamInfo
    
    var body: some View {
        TeamInfoViewTest(viewModel: viewModel)
    }
}


struct TeamInfoViewTest: View {
    var viewModel: ResponseTeamInfo?
    @SwiftUI.Environment(\.presentationMode) var presenterMode

    var body: some View {
        VStack{
            headerView
            teamInfo
        }
    }
    
    var headerView: some View{
        ZStack(alignment: .top, content: {
            if self.viewModel?.venue?.image != nil {
                StadiumImageTest(imageStadiumUrl: (self.viewModel?.venue?.imageUrl)!)
            }
            
            
            VStack(alignment: .center, content: {
                if self.viewModel?.venue?.image != nil {
                    TeamImage(imageTeamUrl: (self.viewModel?.team!.logoUrl)!)
                }
                
                Text(self.viewModel?.team?.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            })
            .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
            
            
            HStack{
                Button(action: {
                    self.presenterMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                })
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                
                Spacer()
                
                Button(action: {
                    // Aqui salvaremos las peliculas como favoritas en una BBDD (1. Firebase | 2. UserDefault)
                }, label: {
                    Image(systemName: "bookmark")
                })
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 20))
            }
            .foregroundColor(Color.red)
            
        })
    }
    
    var teamInfo: some View {
        
        VStack(alignment: .center, spacing: 10, content: {
            
            HStack(alignment: .center, spacing: 40, content: {
                Button(action: {
                    //
                }, label: {
                    Text("Season games")
                        .buttonStyleH1()
                })
                
                
                //Spacer()
                
                Button(action: {
                    //
                }, label: {
                    Text("Stadistics")
                        .buttonStyleH1()
                })
            })
            .padding(.bottom, 20)
            
            
            Text("Club information")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            
            
            if self.viewModel?.team?.founded != nil {
                Text("Founded in")
                    .font(.callout)
                Text("\(self.viewModel?.team?.founded ?? 0)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            if self.viewModel?.venue?.city != nil {
                Text("City")
                    .font(.callout)
                Text("\(self.viewModel?.venue?.city ?? "") (\(self.viewModel?.team?.country ?? ""))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            if self.viewModel?.venue?.name != nil {
                Text("Stadium name")
                    .font(.callout)
                Text(self.viewModel?.venue?.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }

            if self.viewModel?.venue?.capacity != nil {
                Text("Capacity")
                    .font(.callout)
                Text("\(self.viewModel?.venue?.capacity ?? 0)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            if self.viewModel?.venue?.address != nil {
                Text("Address")
                    .font(.callout)
                Text(self.viewModel?.venue?.address ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
            }
            
            
            
        })
        .padding(.top, 20)
    }
}

struct StadiumImageTest: View {
    
    let imageStadiumUrl: URL
    @StateObject private var imageLoaderVM = ImageLoader()
    
    var body: some View {
        ZStack{
//            Rectangle()
//                .fill(Color.gray.opacity(0.3))
//                .cornerRadius(8)
//                .shadow(radius: 10)
            
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(self.imageLoaderVM.image!.size, contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .grayscale(0.9995)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom))
            }
        }
        .onAppear{
            self.imageLoaderVM.loadImage(whit: imageStadiumUrl)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
