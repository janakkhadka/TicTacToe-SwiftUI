//
//  Board.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 14/03/2025.
//
import Foundation

struct GameBoard: Identifiable, Codable { //codeable le chai json haru maa change garna help garxa swift obj lai, identifiable le chai unique idendity dinxa each element lai
    var board: [String]
    
    init() {
        self.board = Array(repeating: "", count: 9)
    }
    
}
