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

                NavigationLink("Play with Computer") {
                    WithComputerView()
                }
                .buttonStyle(CustomButtonStyle())

                NavigationLink("Play with Friend(OFFLINE)") {
                    WithPlayerView()
                }
                .buttonStyle(CustomButtonStyle())
                
                NavigationLink("Play with Friend(ONLINE)") {
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
