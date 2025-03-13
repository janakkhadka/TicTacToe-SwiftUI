//
//  DatabaseManager.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 13/03/2025.
//

import Foundation
import FirebaseDatabase

class DatabaseManager: ObservableObject {
    private let dbRef = Database.database().reference()
    
    @Published var users: [String: Any] = [:]

    func writeData(userID: String, name: String, age: Int) {
        let user: [String: Any] = [
            "name": name,
            "age": age
        ]
        dbRef.child("users").child(userID).setValue(user)
    }
    
    func readData() {
        dbRef.child("users").observe(.value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                DispatchQueue.main.async {
                    self.users = value
                }
            }
        }
    }
}

