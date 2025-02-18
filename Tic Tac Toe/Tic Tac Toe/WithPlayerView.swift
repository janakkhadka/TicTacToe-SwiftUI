//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 16/02/2025.
//

import SwiftUI

struct WithPlayerView: View {
    @State private var board = Array(repeating: "", count: 9) //yo vanya chai -> ["", "", "", "", "", "", "", "", ""]
    @State private var isXTurn = true
    @State private var winner: String? = nil
    @State private var xWinningCount: Int = 0
    @State private var oWinningCount: Int = 0
    
    @State private var isShowAlert: Bool = false
    
    @State private var winnerLine: (start: CGPoint, end: CGPoint)? = nil
    @State private var isHorizontal: Bool = false
    @State private var isVertical: Bool = false
    @State private var isDiagonal: Bool = false
    
    var body: some View {
        VStack {
            //for player who choose O
            Button("Restart") {
                board = Array(repeating: "", count: 9)
                isXTurn = true
                winner = nil
                winnerLine = nil
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotationEffect(.degrees(180))
            .opacity(winner != nil ? 1 : 0)
            
            Text("Won: \(oWinningCount)")
                .rotationEffect(.degrees(180))
            Text("Player: O")
                .rotationEffect(.degrees(180))
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.blue)
            Text(winner == nil ? "Your Turn" : winner == "X" ? "You Lose!" : "You Win!")
                .rotationEffect(.degrees(180))
                .opacity(winner != nil ? 1 : isXTurn ? 0 : 1)
            
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
                        .fill(winner == "X" ? Color.red : Color.blue)
                        .frame(
                            width: isDiagonal ? 350 * 1.3 : (isHorizontal ? 350 : 5),
                            height: isDiagonal ? 5 : (isHorizontal ? 5 : 350)
                        )
                        .position(x: (line.start.x + line.end.x) / 2, y: (line.start.y + line.end.y) / 2)
                        .rotationEffect(isDiagonal ? getRotationAngle(start: line.start, end: line.end) : .degrees(0))
                }
            }
            .frame(width: 360, height: 360)
            
            
            
            
            //for player who choose X
            Text(winner == nil ? "Your Turn" : winner == "O" ? "You Lose!" : "You Win!")
                .opacity(winner != nil ? 1 : isXTurn ? 1 : 0)
            Text("Player: X")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.red)
            Text("Won: \(xWinningCount)")
            
            Button("Restart") {
                board = Array(repeating: "", count: 9)
                isXTurn = true
                winner = nil
                winnerLine = nil
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(winner != nil ? 1 : 0)
        }
        .alert("Player \(winner ?? "No one") wins!", isPresented: $isShowAlert){
            Button("OK", role: .cancel) { }
        } message: {
            Text("Congratulations! Player \(winner ?? "No one") wins the game.")
        }

    }
    
    //to check the winner
    private func checkWinner() {
        let winningCombinations: [[Int]] = [
            [0,1,2], [3,4,5], [6,7,8], // Horizontal
            [0,3,6], [1,4,7], [2,5,8], // Vertical
            [0,4,8], [2,4,6]           // Diagonal
        ]

        for combination in winningCombinations {
            if board[combination[0]] != "" && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] {
                winner = board[combination[0]]
                winnerLine = getLinePosition(for: combination)
                
                isHorizontal = combination[0] + 1 == combination[1]  // horizontal le jiteko ho vane
                isVertical = combination[0] + 3 == combination[1]    // vertical le jiteko ho vane
                isDiagonal = !isHorizontal && !isVertical            // If neither, it's diagonal

                //return
            }
        }
        
        if winner == "X" {
            xWinningCount += 1
            winner = "X"
            isShowAlert = true
        } else if winner == "O" {
            winner = "O"
            oWinningCount += 1
            isShowAlert = true
        }

        if !board.contains("") {
            winner = "Draw"
            isShowAlert = true
        }
        
        return
    }


    
    //winner ko lagi line banauna lai
    private func getLinePosition(for combination: [Int]) -> (CGPoint, CGPoint) {
        let positions: [CGPoint] = (0..<9).map { index in
            let x = CGFloat(index % 3) * 125 + 115 / 2  // Adjust for grid size
            let y = CGFloat(index / 3) * 121 + 122 / 2
            return CGPoint(x: x, y: y)
        }

        // Correct diagonal positions
        if combination == [0, 4, 8] { // Left Top to Right Bottom
            return (positions[0], positions[8]) // Correct order
        } else if combination == [2, 4, 6] { // Right Top to Left Bottom
            return (positions[2], positions[6]) // Correct order
        }

        return (positions[combination.first!], positions[combination.last!])
    }


    
    //lineko rotation ko lagi
    private func getRotationAngle(start: CGPoint, end: CGPoint) -> Angle {
        let dx = end.x - start.x
        let dy = end.y - start.y
        
        return Angle(degrees: atan2(dy, dx) * 180 / .pi)
    }

}

#Preview {
    WithPlayerView()
}
