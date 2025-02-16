//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 16/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var board = Array(repeating: "", count: 9) //yo vanya chai -> ["", "", "", "", "", "", "", "", ""]
    @State private var isXTurn = true
    @State private var winner: String? = nil
    
    var body: some View {
        VStack {
            //for player who choose O
            Text("Won: ")
                .rotationEffect(.degrees(180))
            Text("Player: O")
                .rotationEffect(.degrees(180))
            Text("Your Turn")
                .rotationEffect(.degrees(180))
            
            //board design
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10){
                ForEach(0..<9, id: \.self) { index in
                    Button(action: {
                        if board[index] == "" && winner == nil {
                            board[index] = isXTurn ? "X" : "O"
                            isXTurn.toggle() // isXTurn = !isXTurn, toggle() built in ho
                            print(board)
                        }
                    }){
                        Text(board[index])
                            .font(.largeTitle)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                }
            }
            
            //for player who choose X
            Text("Your Turn")
            Text("Player: X")
            Text("Won: ")
        }

    }
}

#Preview {
    ContentView()
}
