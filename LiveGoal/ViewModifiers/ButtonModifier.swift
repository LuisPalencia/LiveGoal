//
//  ButtonModifier.swift
//  FootballApp
//
//  Created by CICE on 21/03/2022.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .lineLimit(2)
            .frame(width: UIScreen.main.bounds.width * 0.4, height: 50)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            //.clipShape(Capsule())
    }
}

extension View {
    func buttonStyleH1() -> some View {
        self.modifier(ButtonModifier())
    }
}
