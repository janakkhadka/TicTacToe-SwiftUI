//
//  FirebaseTestView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 13/03/2025.
//

import SwiftUI

struct FirebaseTestView: View {
    @StateObject private var dbManager = DatabaseManager()

    var body: some View {
        VStack {
            Button("Save Data") {
                dbManager.writeData(userID: "user123", name: "John Doe", age: 25)
            }
            Button("Load Data") {
                dbManager.readData()
            }
            List(dbManager.users.keys.sorted(), id: \.self) { key in
                if let userData = dbManager.users[key] as? [String: Any],
                   let name = userData["name"] as? String,
                   let age = userData["age"] as? Int {
                    Text("\(name) - \(age) years old")
                }
            }
        }
    }
}


#Preview {
    FirebaseTestView()
}
