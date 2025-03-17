//
//  WithOnlinePlayerView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 16/03/2025.
//

import SwiftUI

struct WithOnlinePlayerView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var isXTurn = true
    @State private var winner: String? = nil
    @State private var xWinningCount: Int = 0
    @State private var oWinningCount: Int = 0
    
    @State private var viewModel = GameViewModel()
    
    @State private var isShowAlert: Bool = false
    
    @State private var winnerLine: (start: CGPoint, end: CGPoint)? = nil
    @State private var isHorizontal: Bool = false
    @State private var isVertical: Bool = false
    @State private var isDiagonal: Bool = false
    
    var body: some View {
        VStack {
            // Computer Section
            Text("Won: \(oWinningCount)")
            Text("Name: O")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.blue)
            Text(winner == nil ? "Name Turn" : winner == "X" ? "Computer Loses!" : "Computer Wins!")
                .opacity(winner != nil ? 1 : isXTurn ? 0 : 1)
            
            // Board Design
            ZStack {
                // Grid Lines
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Rectangle()
                            .frame(width: 5, height: 350)
                            .foregroundColor(.black)
                        Spacer()
                        Rectangle()
                            .frame(width: 5, height: 350)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Rectangle()
                            .frame(width: 350, height: 5)
                            .foregroundColor(.black)
                        Spacer()
                        Rectangle()
                            .frame(width: 350, height: 5)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
                
                // Game Board
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(0..<9, id: \.self) { index in
                        Button(action: {
                            if board[index] == "" && winner == nil {
                                board[index] = isXTurn ? "X" : "O"
                                isXTurn.toggle()
                                checkWinner()
                                viewModel.sendGameData(uuid: UUID(), gameID: 123)
                                
                                // computer ko palo aayesi
                                if !isXTurn && winner == nil {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        computerMove()
                                    }
                                }
                            }
                        }) {
                            Text(board[index])
                                .font(.system(size: 70, weight: .bold))
                                .frame(width: 100, height: 100)
                                .foregroundColor(board[index] == "X" ? .red : .blue)
                        }
                        .disabled(!isXTurn || board[index] != "" || winner != nil)
                    }
                }
                
                // Winner Line
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
            
            // Player Section
            Text(winner == nil ? "Your Turn" : winner == "O" ? "You Lose!" : "You Win!")
                .opacity(winner != nil ? 1 : isXTurn ? 1 : 0)
            Text("You(Name): X")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.red)
            Text("Won: \(xWinningCount)")
            
            // Restart Button
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
        .alert(winner == "Draw" ? "Draw" : "Player \(winner ?? "") wins!", isPresented: $isShowAlert) {
            Button("OK", role: .cancel) { }
        }  message: {
            Text(winner == "Draw" ? "No one wins the game." : "Congratulations! Player \(winner ?? "") wins the game.")
        }
    }
    
    // Computer Move Logic
    private func computerMove() {
        guard winner == nil else { return }
        
        // Find all empty spots
        let emptySpots = board.enumerated().compactMap { $0.element == "" ? $0.offset : nil }
        
        // Choose a random empty spot
        if let randomSpot = emptySpots.randomElement() {
            board[randomSpot] = "O"
            isXTurn.toggle()
            checkWinner()
        }
    }
    
    // Check Winner Logic
    private func checkWinner() {
        let winningCombinations: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Horizontal
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Vertical
            [0, 4, 8], [2, 4, 6]              // Diagonal
        ]

        for combination in winningCombinations {
            if board[combination[0]] != "" && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] {
                winner = board[combination[0]]
                winnerLine = getLinePosition(for: combination)
                
                isHorizontal = combination[0] + 1 == combination[1]
                isVertical = combination[0] + 3 == combination[1]
                isDiagonal = !isHorizontal && !isVertical

                if winner == "X" {
                    xWinningCount += 1
                } else if winner == "O" {
                    oWinningCount += 1
                }
                
                isShowAlert = true
                return
            }
        }

        if !board.contains("") {
            winner = "Draw"
            isShowAlert = true
        }
    }
    
    // Get Line Position for Winner
    private func getLinePosition(for combination: [Int]) -> (CGPoint, CGPoint) {
        let positions: [CGPoint] = (0..<9).map { index in
            let x = CGFloat(index % 3) * 125 + 115 / 2
            let y = CGFloat(index / 3) * 121 + 122 / 2
            return CGPoint(x: x, y: y)
        }

        if combination == [0, 4, 8] {
            return (positions[0], positions[8])
        } else if combination == [2, 4, 6] {
            return (positions[2], positions[6])
        }

        return (positions[combination.first!], positions[combination.last!])
    }
    
    // Get Rotation Angle for Diagonal Line
    private func getRotationAngle(start: CGPoint, end: CGPoint) -> Angle {
        let dx = end.x - start.x
        let dy = end.y - start.y
        return Angle(degrees: atan2(dy, dx) * 180 / .pi)
    }
}

#Preview {
    WithOnlinePlayerView()
}
