//
//  HomeView.swift
//  FootballApp
//
//  Created by CICE on 21/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        TabView(selection: self.$viewModel.selectedTabItem,
                content:  {
                    ForEach(self.viewModel.tabItemViewModels, id: \.self){ item in
                        tabView(tabItemType: item.type)
                            .tabItem {
                                Image(systemName: item.imageName)
                                Text(item.title)
                            }.tag(item.type)
                    }
                })
            .accentColor(.red)
            //.environment(\.colorScheme, .dark)
    }
    
    @ViewBuilder
    func tabView(tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .standing:
            LeagueClassificationCoordinator.navigation()
        case .games:
            LeagueRoundsCoordinator.navigation()
        case .top:
            RankingsCoordinator.navigation()
        case .favourites:
            FavouritesCoordinator.navigation()
        case .profile:
            ProfileView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
