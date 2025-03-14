//
//  FirstView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 18/02/2025.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("JK Tic-Tac-Toe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Navigate to 2-Player Mode
                NavigationLink("Play with Computer") {
                    WithComputerView()
                }
                .buttonStyle(CustomButtonStyle())

                // Navigate to Computer Mode
                NavigationLink("Play with Friend") {
                    WithPlayerView()
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
        }
    }
}


#Preview {
    FirstView()
}
