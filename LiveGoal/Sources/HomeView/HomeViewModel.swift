//
//  HomeViewModel.swift
//  FootballApp
//
//  Created by CICE on 21/03/2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var selectedTabItem: TabItemViewModel.TabItemType = .standing
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "tv", title: "Standing", type: .standing),
        TabItemViewModel(imageName: "play.tv.fill", title: "Games", type: .games),
        TabItemViewModel(imageName: "person.2.circle", title: "Rankings", type: .top),
        TabItemViewModel(imageName: "magnifyingglass", title: "Favourites", type: .favourites),
        TabItemViewModel(imageName: "person.fill", title: "Profile", type: .profile)
    ]
    
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType{
        case standing
        case games
        case top
        case favourites
        case profile
    }
}
