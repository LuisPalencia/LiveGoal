//
//  ProgressBar.swift
//  LiveGoal
//
//  Created by CICE on 28/03/2022.
//

import SwiftUI

struct ProgressBar: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    //.opacity(0.3)
                    .foregroundColor(.green)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.blue)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}
