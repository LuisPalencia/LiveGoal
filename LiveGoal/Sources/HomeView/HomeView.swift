//
//  HomeView.swift
//  FootballApp
//
//  Created by CICE on 21/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedTabItem: TabItemViewModel.TabItemType = .standing
    
    var body: some View {
        TabView(selection: self.$selectedTabItem,
                content:  {
                    LeagueClassificationCoordinator.navigation()
                     .tabItem {
                        Image("standing")
                            .renderingMode(.template)
                            .foregroundColor(.green)
                        Text("Standing")
                     }
                        .tag(TabItemViewModel.TabItemType.standing)
                    
                    LeagueRoundsCoordinator.navigation()
                     .tabItem {
                        Image(systemName: "calendar")
                        Text("Games")
                     }
                        .tag(TabItemViewModel.TabItemType.games)
                    RankingsCoordinator.navigation()
                     .tabItem {
                        Image("ranking")
                            .renderingMode(.template)
                        Text("Ranking")
                     }
                        .tag(TabItemViewModel.TabItemType.top)
                    
                    FavouritesCoordinator.navigation()
                     .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favourites")
                     }
                        .tag(TabItemViewModel.TabItemType.favourites)
                    
                    ProfileView()
                     .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                     }
                        .tag(TabItemViewModel.TabItemType.profile)
                    
                })
            .accentColor(.red)
            //.environment(\.colorScheme, .dark)
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
