//
//  TrophyItem.swift
//  LiveGoal
//
//  Created by CICE on 29/03/2022.
//

import SwiftUI

struct TrophyItem: View {
    
    var model: PlayerTrophie = PlayerTrophiesServerModel.stubbedPlayerTrophies
    var color: UIColor = UIColor(Color.black)
    
    init(model: PlayerTrophie){
        self.model = model
        
        switch self.model.place {
        case "Winner":
            self.color = #colorLiteral(red: 0.9882352941, green: 0.7607843137, blue: 0, alpha: 1)
        case "2nd Place":
            self.color = UIColor.lightGray
        case "3rd Place":
            self.color = #colorLiteral(red: 0.9101801515, green: 0.4515265822, blue: 0, alpha: 1)
        default:
            self.color = UIColor(Color.black)
        }
    }
    
    var body: some View {
        HStack(spacing: 20, content: {
            Image("trophy")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
                .foregroundColor(Color(self.color))
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text("\(self.model.league ?? "") (\(self.model.country ?? ""))")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Season: \(self.model.season ?? "")")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("Place: \(self.model.place ?? "")")
                    .font(.headline)
                    .fontWeight(.semibold)
                
            })
            
            Spacer()
        })
        .padding()
    }
}

struct TrophyItem_Previews: PreviewProvider {
    static var previews: some View {
        TrophyItem(model: PlayerTrophiesServerModel.stubbedPlayerTrophies)
    }
}
