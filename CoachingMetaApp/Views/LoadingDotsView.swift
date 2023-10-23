//
//  LoadingDotsView.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/20/23.
//

import SwiftUI

public struct LoadingDots: View {
    @State private var scale: CGFloat = 1.0
    private var message: String = "Loading"
    
    @ViewBuilder func circle(_ delay: Double = 0.0) -> some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.orange)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(delay), value: scale)
            .onAppear {
                withAnimation {
                    self.scale = 0.5
                }
            }
    }
    
    public var body: some View {
        VStack {
            Text(message).font(.title).bold()
            HStack {
                circle()
                circle(0.3)
                circle(0.6)
            }
        }
    }
}
