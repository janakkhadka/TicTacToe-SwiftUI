//
//  TrialView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 16/02/2025.
//

import SwiftUI

struct TrialView: View {
    var body: some View {
        ZStack {
            // Vertical Lines
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 5, height: 250)
                        .foregroundColor(.black)
                    Spacer()
                    Rectangle()
                        .frame(width: 5, height: 250)
                        .foregroundColor(.black)
                    Spacer()
                }
                Spacer()
            }
            
            // Horizontal Lines
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 250, height: 5)
                        .foregroundColor(.black)
                    Spacer()
                    Rectangle()
                        .frame(width: 250, height: 5)
                        .foregroundColor(.black)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(width: 260, height: 260)
    }
}

struct TicTacToeGrid_Previews: PreviewProvider {
    static var previews: some View {
        TrialView()
    }
}

