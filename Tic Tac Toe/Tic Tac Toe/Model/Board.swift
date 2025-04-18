//
//  Board.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 14/03/2025.
//
import Foundation

struct GameBoard: Codable { //codeable le chai json haru maa change garna help garxa swift obj lai, identifiable le chai unique idendity dinxa each element lai
    var userName: String
    var boardValue: [String]
    var isXTurn: Bool
    var winner: String?
    var xWinningCount: Int
    var oWinningCount: Int
    var isShowAlert: Bool
    //var winnerLine: (start: CGPoint, end: CGPoint)?
    
    init() {
        self.userName = UserDefaults.standard.string(forKey: "username") ?? ""
        self.boardValue = Array(repeating: "", count: 9)
        self.isXTurn = true
        self.winner = nil
        self.xWinningCount = 0
        self.oWinningCount = 0
        self.isShowAlert = false
    }
    
}

