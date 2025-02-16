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
    @State private var winnerLine: (start: CGPoint, end: CGPoint)? = nil
    
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
            //gridline of board
            ZStack{
                //thado line
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Rectangle()
                            .frame(width:5, height: 350)
                            .foregroundColor(.black)
                        Spacer()
                        Rectangle()
                            .frame(width:5, height: 350)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
                //terso line
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Rectangle()
                            .frame(width:350, height: 5)
                            .foregroundColor(.black)
                        Spacer()
                        Rectangle()
                            .frame(width:350, height: 5)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20){
                    ForEach(0..<9, id: \.self) { index in
                        Button(action: {
                            if board[index] == "" && winner == nil {
                                board[index] = isXTurn ? "X" : "O"
                                isXTurn.toggle() // isXTurn = !isXTurn, toggle() built in ho
                                print(board)
                                checkWinner()
                            }
                        }){
                            Text(board[index])
                                .font(.system(size: 70, weight: .bold))
                                .frame(width: 100, height: 100)
                                .foregroundColor(board[index] == "X" ? .red : .blue)
                                //.background(.gray)
                        }
                    }
                }
                
                //line tannako lagi jitesi
                if let line = winnerLine {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 350, height: 5)
                        .position(x: (line.start.x + line.end.x)/2, y: (line.start.y + line.end.y)/2)
                        .rotationEffect(getRotationAngle(start: line.start, end: line.end))
                        //.animation(.easeInOut(duration: 0.5))
                }
            }
            .frame(width: 360, height: 360)
            
            
            
            
            //for player who choose X
            Text("Your Turn")
            Text("Player: X")
            Text("Won: ")
        }

    }
    
    //to check the winner
    private func checkWinner() {
        let winningCombinations: [[Int]] = [
            [0,1,2], [3,4,5], [6,7,8], //horizontal ko lagi
            [0,3,6], [1,4,7], [2,5,8], //vertical ko lagi
            [0,4,8], [2,4,6] //diagonal ko lagi
        ]
        
        for combination in winningCombinations {
            if board[combination[0]] != "" && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] {
                winner = board[combination[0]]
                winnerLine = getLinePosition(for: combination)
                
                return
            }
        }
        
        if !board.contains(""){
            winner = "Draw"
        }
    }
    
    //winner ko lagi line banauna lai
    private func getLinePosition(for combination: [Int]) -> (CGPoint, CGPoint) {
        let positions: [CGPoint] = [
            CGPoint(x: 75, y: 75), CGPoint(x: 200, y: 75), CGPoint(x: 350, y: 75),
            CGPoint(x: 75, y: 200), CGPoint(x: 200, y: 150), CGPoint(x: 350, y: 200),
            CGPoint(x: 75, y: 350), CGPoint(x: 200, y: 350), CGPoint(x: 350, y: 350)
        ]
        return (positions[combination[0]], positions[combination[2]])
    }
    
    //lineko rotation ko lagi
    private func getRotationAngle(start: CGPoint, end: CGPoint) -> Angle {
        let dx = end.x - start.x
        let dy = end.y - start.y
        
        return Angle(radians: atan2(dy,dx))
    }
}

#Preview {
    ContentView()
}
