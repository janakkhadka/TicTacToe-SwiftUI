//
//  WithOnlinePlayerView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 16/03/2025.
//

import SwiftUI

struct WithOnlinePlayerView: View {

    
    @StateObject private var viewModel = GameViewModel()
    //stateobject le chai view lai persist garxa child view maa ni
    
    //@State private var isShowAlert: Bool = false
    
    @State private var winnerLine: (start: CGPoint, end: CGPoint)? = nil
    @State private var isHorizontal: Bool = false
    @State private var isVertical: Bool = false
    @State private var isDiagonal: Bool = false
    
    private let currentUUID: UUID = UUID()
    
    var body: some View {
        VStack {
            // Computer Section
            Text("Network Status:")
            Text("Ping:")
            Text("Won: \(viewModel.board.oWinningCount)")
            Text("Name: O")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.blue)
            Text(viewModel.board.winner == nil ? "Name Turn" : viewModel.board.winner == "X" ? "Computer Loses!" : viewModel.board.winner == "Draw" ? "Draw" : "Name Wins!")
                .opacity(viewModel.board.winner != nil ? 1 : viewModel.board.isXTurn ? 0 : 1)
            
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
                GameBoardView(viewModel: viewModel, currentUUID: currentUUID, checkWinner: checkWinner, computerMove: computerMove)
                
                // Winner Line
                if let line = winnerLine {
                    Rectangle()
                        .fill(viewModel.board.winner == "X" ? Color.red : Color.blue)
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
            Text(viewModel.board.winner == nil ? "Your Turn" : viewModel.board.winner == "O" ? "You Lose!": viewModel.board.winner == "Draw" ? "Draw" : "You Win!")
                .opacity(viewModel.board.winner != nil ? 1 : viewModel.board.isXTurn ? 1 : 0)
            Text("You(Name): X")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.red)
            Text("Won: \(viewModel.board.xWinningCount)")
            Text("Ping:")
            Text("Network Status:")
            
            // Restart Button
            Button("Restart") {
                viewModel.board.boardValue = Array(repeating: "", count: 9)
                viewModel.board.isXTurn = true
                viewModel.board.winner = nil
                //winnerLine = nil
                viewModel.sendGameData(uuid: currentUUID)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(viewModel.board.winner != nil ? 1 : 0)
        }
        .alert(viewModel.board.winner == "Draw" ? "Draw" : "Player \(viewModel.board.winner ?? "") wins!", isPresented: $viewModel.board.isShowAlert) {
            Button("OK", role: .cancel) { }
        }  message: {
            Text(viewModel.board.winner == "Draw" ? "No one wins the game." : "Congratulations! Player \(viewModel.board.winner ?? "") wins the game.")
        }
        .onChange(of: viewModel.board.boardValue) {
            checkWinner()
            if(viewModel.board.winner == "Draw" || viewModel.board.boardValue == Array(repeating: "", count: 9)){
                winnerLine = nil
            }
        }
    }
    
    // Computer Move Logic
    private func computerMove() {
        guard viewModel.board.winner == nil else { return }
        
        // Find all empty spots
        let emptySpots = viewModel.board.boardValue.enumerated().compactMap { $0.element == "" ? $0.offset : nil }
        
        // Choose a random empty spot
        if let randomSpot = emptySpots.randomElement() {
            viewModel.board.boardValue[randomSpot] = "O"
            viewModel.board.isXTurn.toggle()
            checkWinner()
        }
    }
    
    // Check Winner Logic
    private func checkWinner() {
        let winningCombinations: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Horizontal
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Vertical
            [0, 4, 8], [2, 4, 6]            // Diagonal
        ]

        for combination in winningCombinations {
            if viewModel.board.boardValue[combination[0]] != "" && viewModel.board.boardValue[combination[0]] == viewModel.board.boardValue[combination[1]] && viewModel.board.boardValue[combination[1]] == viewModel.board.boardValue[combination[2]] {
                viewModel.board.winner = viewModel.board.boardValue[combination[0]]
                winnerLine = getLinePosition(for: combination)
                
                isHorizontal = combination[0] + 1 == combination[1]
                isVertical = combination[0] + 3 == combination[1]
                isDiagonal = !isHorizontal && !isVertical

                if viewModel.board.winner == "X" {
                    viewModel.board.xWinningCount += 1
                } else if viewModel.board.winner == "O" {
                    viewModel.board.oWinningCount += 1
                }
                
                viewModel.board.isShowAlert = true
                return
            }
        }

        if !viewModel.board.boardValue.contains("") {
            viewModel.board.winner = "Draw"
            viewModel.board.isShowAlert = true
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


struct GameBoardView: View {
    @ObservedObject var viewModel: GameViewModel
    let currentUUID : UUID
    var checkWinner: () -> Void
    var computerMove: () -> Void

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
            ForEach(0..<9, id: \.self) { index in
                Button(action: {
                    if viewModel.board.boardValue[index] == "" && viewModel.board.winner == nil {
                        viewModel.board.boardValue[index] = viewModel.board.isXTurn ? "X" : "O"
                        viewModel.board.isXTurn.toggle()
                        checkWinner()
                        viewModel.sendGameData(uuid: currentUUID)
                        
                        // computer ko palo aayesi
                        if !viewModel.board.isXTurn && viewModel.board.winner == nil {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                print(viewModel.board.isXTurn)
                                //viewModel.fetchGameData(uuid: UUID(), gameID: "123")
                                computerMove()
                                viewModel.sendGameData(uuid: currentUUID)
                            }
                        }
                    }
                }) {
                    Text(viewModel.board.boardValue[index])
                        .font(.system(size: 70, weight: .bold))
                        .frame(width: 100, height: 100)
                        .foregroundColor(viewModel.board.boardValue[index] == "X" ? .red : .blue)
                }
                .disabled(!viewModel.board.isXTurn || viewModel.board.boardValue[index] != "" || viewModel.board.winner != nil)
            }
        }
        .onAppear {
           viewModel.fetchGameData(uuid: currentUUID)
                }
    }
}


#Preview {
    WithOnlinePlayerView()
}
