//
//  LoaderModifier.swift
//  FootballApp
//
//  Created by CICE on 17/03/2022.
//

import SwiftUI

struct LoaderModifier: ViewModifier {

    var state: ViewModelState
    var loader: AnyView
    
    init(state: ViewModelState, loader: AnyView){
        self.state = state
        self.loader = loader
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            if state == ViewModelState.loading{
                loader
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
}

extension View {
    func loader(state: ViewModelState) -> some View {
        self.modifier(LoaderModifier(state: state, loader: AnyView(HudView())))
    }
}
