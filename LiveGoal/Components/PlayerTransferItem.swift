//
//  PlayerTransferItem.swift
//  LiveGoal
//
//  Created by CICE on 29/03/2022.
//

import SwiftUI

struct PlayerTransferItem: View {
    
    var model: Transfer = PlayerTransfersServerModel.stubbedPlayerTransfer
    var textTransfer = ""
    @ObservedObject var imageLoaderTeamInVM = ImageLoader()
    @ObservedObject var imageLoaderTeamOutVM = ImageLoader()
    
    init(model: Transfer){
        self.model = model
        
        if self.model.type == "N/A"{
            self.textTransfer = "Free"
        }else{
            self.textTransfer = self.model.type ?? ""
        }
        
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5, content: {
            
            Text(self.textTransfer)
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(alignment: .center, spacing: 10, content: {
                VStack(alignment: .center, spacing: 20, content: {
                    if self.imageLoaderTeamOutVM.image != nil {
                        Image(uiImage: self.imageLoaderTeamOutVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                        
                    }else{
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                    }
                    
                    Text(self.model.teams?.teamOut?.name ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                })
                .frame(maxWidth: .infinity)
                
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .center, spacing: 20, content: {
                    if self.imageLoaderTeamInVM.image != nil {
                        Image(uiImage: self.imageLoaderTeamInVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                        
                    }else{
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                    }
                    
                    Text(self.model.teams?.teamIn?.name ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                })
                .frame(maxWidth: .infinity)
            })
            
            Text(self.model.date ?? "")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.top, 5)
            
            
        })
        .padding([.top, .bottom], 10)
        .onAppear{
            self.imageLoaderTeamInVM.loadImage(whit: (self.model.teams?.teamIn?.logoUrl)!)
            self.imageLoaderTeamOutVM.loadImage(whit: (self.model.teams?.teamOut?.logoUrl)!)
        }
    }
    
    var body2: some View {
        HStack(spacing: 10, content: {
            VStack(alignment: .center, spacing: 20, content: {
                if self.imageLoaderTeamInVM.image != nil {
                    Image(uiImage: self.imageLoaderTeamInVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                    
                }else{
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                }
                
                Text(self.model.teams?.teamIn?.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
            })
            .frame(maxWidth: .infinity)
            .padding(.leading, 10)
            
            VStack(spacing: 20, content: {
                Text(self.textTransfer)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                Text(self.model.date ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
            })
            
            VStack(alignment: .center, spacing: 20, content: {
                if self.imageLoaderTeamOutVM.image != nil {
                    Image(uiImage: self.imageLoaderTeamOutVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                    
                }else{
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                }
                
                Text(self.model.teams?.teamOut?.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
            })
            .frame(maxWidth: .infinity)
            .padding(.leading, 10)
        })
        .onAppear{
            self.imageLoaderTeamInVM.loadImage(whit: (self.model.teams?.teamIn?.logoUrl)!)
            self.imageLoaderTeamOutVM.loadImage(whit: (self.model.teams?.teamOut?.logoUrl)!)
        }
    }
}

struct PlayerTransferItem_Previews: PreviewProvider {
    static var previews: some View {
        PlayerTransferItem(model: PlayerTransfersServerModel.stubbedPlayerTransfer)
    }
}
