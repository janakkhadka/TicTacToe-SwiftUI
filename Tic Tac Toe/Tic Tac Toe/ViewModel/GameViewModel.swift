//
//  ViewModel.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 14/03/2025.
//

import Foundation
import FirebaseDatabase

class GameViewModel: ObservableObject {
    let dbRef = Database.database(url: "https://tic-tac-toe-f606f-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    @Published var board = GameBoard()
    
    //value database maa pathauna lai
    func sendGameData() {
        do {
            let data = try JSONEncoder().encode(board)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                dbRef.child("games").child(UUID().uuidString).setValue(json)
            }
        } catch {
            print("error encoding")
        }
    }
    
    //value fetch garna lai
    func fetchGameData() {
        
    }
    
    
    
    
}
