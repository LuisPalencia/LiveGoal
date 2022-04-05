//
//  ButtonLoginModifier.swift
//  LiveGoal
//
//  Created by CICE on 04/04/2022.
//

import SwiftUI

struct ButtonLoginModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .lineLimit(2)
            .frame(width: UIScreen.main.bounds.width * 0.85, height: 50)
            .foregroundColor(Color.white)
            .background(Color.blue.opacity(0.7))
            .clipShape(Capsule())
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 5, y: 5)
    }
}

extension View {
    func loginButtonStyle() -> some View {
        self.modifier(ButtonLoginModifier())
    }
}
