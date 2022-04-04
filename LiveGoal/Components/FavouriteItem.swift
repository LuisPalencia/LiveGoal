//
//  FavouriteItem.swift
//  LiveGoal
//
//  Created by CICE on 04/04/2022.
//

import SwiftUI

struct FavouriteItem: View {
    
    var model: DownloadNewModel
    @ObservedObject var imageLoaderVM = ImageLoader()
    
    init(model: DownloadNewModel){
        self.model = model
        self.imageLoaderVM.loadImage(whit: URL(string: model.logo)!)
    }
    
    var body: some View {
        VStack(spacing: 20){
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                
            }else{
                Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]), startPoint: .bottom, endPoint: .top))
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
            
            Text(self.model.name)
                .font(.headline)
                .fontWeight(.bold)
                .frame(width: 150)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct FavouriteItem_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteItem(model: DownloadNewModel(pId: "531", pName: "Athletic Club", pLogo: "https://media.api-sports.io/football/teams/531.png"))
    }
}
