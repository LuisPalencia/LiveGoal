//
//  MatchesList.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import SwiftUI

struct MatchesList: View {
    
    let matches: [MatchViewModel]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 0, content: {
                ForEach(self.matches) { match in
                    NavigationLink(
                        destination: DetailMatchCoordinator.view(dto: DetailMatchCoordinatorDTO(match: match)),
                        label: {
                            MatchResult(model: match)
                        })
                        .buttonStyle(PlainButtonStyle())
                    
                }
            })
        })
    }
}

//struct MatchesList_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchesList()
//    }
//}
