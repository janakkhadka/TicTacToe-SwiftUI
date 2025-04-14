//
//  ViewModel.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 14/03/2025.
//

import Foundation
import FirebaseDatabase

class GameViewModel: ObservableObject {
    let savedUsername: String = UserDefaults.standard.string(forKey: "username") ?? ""
    let dbRef = Database.database(url: "https://tic-tac-toe-f606f-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    @Published var board = GameBoard()
    
    
    
    //value database maa pathauna lai
    func sendGameData(uuid: UUID) {
        do {
            let data = try JSONEncoder().encode(board)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                dbRef.child(savedUsername).child(uuid.uuidString).setValue(json)
            }
        } catch {
            print("error encoding: \(error.localizedDescription)")
        }
    }
    
    //value fetch garna lai
    func fetchGameData(uuid: UUID) {
        dbRef.child(savedUsername).child(uuid.uuidString).observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                guard let value = snapshot.value else { return }
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let board = try JSONDecoder().decode(GameBoard.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.board = board
                    }//
                } catch {
                    print("Error decoding board: \(error.localizedDescription)")
                }
            } else {
                print("No game data found for UUID: \(uuid.uuidString)")
            }
        }
    }

    
}
