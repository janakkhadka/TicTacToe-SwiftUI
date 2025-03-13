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

    func writeData(userID: String, name: String, age: Int) {
        let user: [String: Any] = [
            "name": name,
            "age": age
        ]
        dbRef.child("users").child(userID).setValue(user)
    }
}

