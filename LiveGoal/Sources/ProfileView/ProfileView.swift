//
//  ProfileView.swift
//  FootballApp
//
//  Created by CICE on 22/03/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModelSession: LoginViewModel
    
    var body: some View {
        if self.viewModelSession.userLogged != nil{
            VStack(spacing: 40){
                Image("laliga_logo_color")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 35)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Button(action: {
                    self.viewModelSession.logoutSession()
                }, label: {
                    Text("Logout")
                        .loginButtonStyle()
                })
                
                Spacer()
                
            }
            .padding(.top, 40)
        }else{
            ContentView()
        }
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
