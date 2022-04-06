//
//  ContentView.swift
//  FootballApp
//
//  Created by CICE on 12/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModelSession: LoginViewModel
    
    var body: some View {
        //LeagueClassificationCoordinator.navigation()
        //HomeView()
        if self.viewModelSession.userLogged != nil {
            HomeView()
        }else{
            LoginView(authType: .signIn)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
