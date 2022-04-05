//
//  TextFieldLoginModifier.swift
//  LiveGoal
//
//  Created by CICE on 04/04/2022.
//

import SwiftUI

struct TextFieldLoginModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.headline)
            .lineLimit(1)
            .frame(width: UIScreen.main.bounds.width * 0.85, height: 50)
            .background(Color(red: 239/255, green: 243/255, blue: 244/255, opacity: 1.0))
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 5, y: 5)
    }
}

extension View {
    func textFieldLoginStyle() -> some View {
        self.modifier(TextFieldLoginModifier())
    }
}
