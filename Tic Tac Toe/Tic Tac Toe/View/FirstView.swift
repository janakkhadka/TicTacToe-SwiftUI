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

                NavigationLink("Computer") {
                    WithComputerView()
                }
                .buttonStyle(CustomButtonStyle())

                NavigationLink("2-Player(OFFlINE)") {
                    WithPlayerView()
                }
                .buttonStyle(CustomButtonStyle())
                
                NavigationLink("2-Player(ONLINE)") {
                    WithOnlinePlayerView()
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
